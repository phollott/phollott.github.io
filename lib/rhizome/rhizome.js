var rhizomeBase = angular.module('rhizome', []);

/**
 * This is really just a hack to run jsonp through jsFiddle
 *      $scope.getJSONData = function() {
 *          jsonpService.getData(function(data) {
 *              alert(JSON.stringify(data))
 *          }, url)
 *      }
 */
rhizomeBase.factory('jsonpService', function ($http, $timeout) {
    var svc = {}, jsonp_data   
    jsonp = function(data) {
        jsonp_data = data
    }

    svc.getData = function(callback, url) {
        $http({
            method: "JSONP",
            params: {
                input: "GM",
                callback: "jsonp"
            },
            url: url,
            isArray: true
        }).success(function(data, status) {
            callback(jsonp_data)
        }).error(function(data, status) {
            $timeout(function() {
                callback(jsonp_data)
            }, 1000);
//            callback(jsonp_data)
        });
    };
    
    return svc
});

rhizomeBase.factory('codeService', function () {
    var svc = {}

    svc.codedConcept = Object;
    svc.initialFrame = null;

    svc.loadCodedConcepts = function (content) {
        svc.initialFrame = content.group.question[0]
            .options.reference;  
        var contained = content.contained;
        for (co in contained) {
            var definedConcept = contained[co].define.concept;
            for (cd in definedConcept) {
                definedConcept[cd].system = contained[co].define.system;
            }
            svc.codedConcept[contained[co].id] = definedConcept;
        }
    };

    svc.getInitialFrame = function () {
        return svc.initialFrame;  
    }
    
    svc.getCodedConcept = function (optionReference, removeHash) {
        if (removeHash) {
            optionReference = optionReference.substr(1);
        }
        return (svc.codedConcept[optionReference]);
    };

    return svc
});

/**
 * This service is responsible for loading a careplan,
 * and a target for binding to the careplan
 * 1) loadCareplan(url)
 */
rhizomeBase.factory('rhsCareplan', function (jsonpService) {
    var svc = {}, resourceCollection = [],
        buttonCollection = [],
        resourceIndex

        svc.loadResource = function (url) {
            // Todo: check if we already have this resource loaded
            // and maybe resource collection should be exposed
            svc.url = url
            jsonpService.getData(function (resource) {
                svc.setResource(resource)
            }, url + '.json')
        }

    svc.setResource = function (res) {
        buttonCollection.push({
            text: res.title
        })
        resourceIndex = resourceCollection.push({
            url: svc.url,
            resource: res
        })
        svc.resource = res
    }

    svc.resetResource = function (index) {
        resourceIndex = index + 1
        svc.resource = resourceCollection[resourceIndex - 1].resource
        return true
    }

    svc.getButtons = function () {
        return buttonCollection
    }

    return svc
});

/**
 * Bind to service rhsCareplan using watch instead of broadcast
 */
rhizomeBase.directive('rhzIonCareplanContext', function (rhsCareplan) {
    return {
        restrict: 'AE',
        link: function (scope, element, attr) {
            scope.$watch(function () {
                return rhsCareplan.resource.content
            }, function (content) {
                if (content) {
                    scope.content = content
                }
            });
        },
        template: '<div class="card"><div class="item item-icon-left pull-right"> <i class="icon ion-home"></i><h2>Rhizome: Goals and<br/> Concerns</h2></div><div class="list"><div class="item item-divider">Concerns</div> <a ng-repeat="goal in content.goal" class="item item-text-wrap"><h5>{{goal.description}}</h5></a></div><div class="item item-icon-right pull-right"><i class="icon ion-arrow-right-a"></i><h3>Swipe from right to left to <br/>progress through careplan.</h3></div></div>'
    };
});

/**
 * Bind to service using watch instead of broadcast
 */
rhizomeBase.directive('rhzIonCareplanSplash', function (rhsCareplan) {
    return {
        restrict: 'AE',
        transclude: 'true',
        link: function (scope, element, attr) {
            scope.$watch(function () {
                return rhsCareplan.resource
            }, function (resource) {
                if (resource) {
                    scope.title = resource.title
                }
            });
        },
        template: '<div class="card"><div class="item item-icon-left pull-right"> <i class="icon ion-home"></i><h2>Rhizome: Q4C</h2><h3>{{title}}</h3></div><div class="item item-body" ng-transclude></div><div class="item item-icon-right pull-right"><i class="icon ion-arrow-right-a"></i><h3>Swipe from right to left to <br/>progress through careplan.</h3></div></div>'
    };
});


rhizomeBase.directive('rhzCareplanTimeline', function () {
    return {
        link: function ($scope, $element, $attr) {
            var timeline, options = {
                width: '100%',
                editable: false,
                height: 300
            }

            $scope.$on('RhzCareplan', 
            function (evt, obj) {
                var timelineArray = [], 
                    content = obj.resource.content
                for (a in content.activity) {
                    var act = content.activity[a],
                        item = {
                            id: a,
                            className: "timeline-item",
                            content: act.simple.details,
                            start: act.simple.timingPeriod.start
                        }
                    timelineArray.push(item)
                }
                var items = new vis.DataSet(timelineArray); 
                timeline = new vis.Timeline(
                    $element[0], 
                    items, 
                    options)
                .on('select', function (properties) { // triggers twice for some reason
                    alert('select'+JSON.stringify(properties));
                });
            });
        }         
    }
});

// Needs some refactoring to separate Ionic and FHIR components
rhizomeBase.directive('rhzIonQuestionnaire', function () {
    return {
        restrict: 'E',
        link: function (scope, element, attrs) {
            scope.$on('RhzQuestionnaire', function (evt, obj) {
                if (obj.resourceContent) {
                    scope.q4c = obj.resourceContent;
                    scope.groupHeader = obj.resourceContent.group.header;
                    scope.group = obj.resourceContent.group;
                }
            });                
        },
        template: '<div class="col">' +
           '<div class="row responsive-sm" >' +
           '<div class="col q4c-sq1">' +
           '<svg rhz-svg="" id="rhizSvg" version="1.1" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"></svg>' +
            '</div>' +
            '<div class="col">' +
            '<div ng-bind="q4c.name.text" class="label q4c-sq2"></div>' +
            '<ol id="questions" class="buttonlist q4c-sq2" rhz-question-group=""></ol>' +
            '<div class="q4c-sq2">' +
//            '<button class="buttonhalf" ng-click="restartQuestionnaire()">Restart Q4C</button>' +
//            '<button class="buttonhalf" ng-click="showPayload()">Show FHIR</button>' +
            '</div>' +
            '</div>' +
            '</div>'
    }
});

rhizomeBase.directive('rhzQuestionGroup', function (codeService, rhsCareplan) {
    return {
        link: function (scope, element, attrs) {
            
            scope.loadGroup = function (question, optCode, optCodeSys) {
                var group = question.group;
                for (g in group) {
                    var coding = group[g].name.coding;
                    for (c in coding) {
                        if ((coding[c].code === optCode) && (coding[c].system === optCodeSys)) {
                            var opt = group[g].question[0].options.reference
                            scope.$broadcast('RhzFocusSvg', { 
                                'frame': opt })
                            scope.group = group[g];
                            break;
                        }
                    }
                }
                return;
            };
            
            scope.getOptions = function (optRef) {
                return codeService.getCodedConcept(optRef, true);
            };
            
            scope.loadCareplan = rhsCareplan.loadCareplan /*(url)function (url) {
                rhsCareplan.loadCareplan(url)
//                scope.$emit('RhzCareplanUrl', { 'url': url })
            }*/
        },
        template: 
        '<li ng-repeat="question in group.question">' +
        '<div class="question">{{question.text}}</div>' +
        '<ol id="options" class="buttonlist">' +
        '<li ng-if="group.subject.reference">' +
        '<button class="buttonface" ng-click="loadCareplan(group.subject.reference)">Load Careplan</button></li>' +
        '<li ng-repeat="option in getOptions(question.options.reference)">' +
        '<button class="buttonface" ng-click="loadGroup(question, option.code, option.system)" ng-bind="option.display"></button>' +
        '</li></ol>' +
        '<li/>'
    }
});

rhizomeBase.directive('rhzSvg', function () {
    return {
        link: function ($scope, $element, $attr) {
            var svg, svgRoot = Snap($element[0])
                    
            $scope.$on('RhzFocusSvg', function (evt, obj) {
                if (obj.svg) {
                    loadSvg(obj.svg)
                    focusFrame(obj.frame, 0)
                } else {
                    focusFrame(obj.frame, 2000)
                }
            });
         
            loadSvg = function(text) {
                var svgFrag = Snap.parse(text)
                svgRoot.append(svgFrag)
                svg = svgRoot.select("#svg")
            }
    
            focusFrame = function(frId, dur) {
                var fr = svg.select(frId)
                svg.animate({
                    x: 0-fr.attr('x'),
                    y: 0-fr.attr('y')
                }, dur)
            }
 
        }
    }
});

rhizomeBase.directive('timelineJs',  function ($timeout) {
    return {
        restrict: 'A',
        link: function (scope, elem, attrs) {
            postpone = $timeout(function() {
                createStoryJS({
                    type:       'timeline',
                    width:      '800',
                    height:     '600',
                    source:     scope.events,
                    embed_id:   'my-timeline'
                });
            }, 50);
            console.log("Running timelineJS");
        }
    }
});

