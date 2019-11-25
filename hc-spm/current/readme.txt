1. Add the Development folder as a sibling to the other folders in Samples from Dropbox.

Samples from Dropbox
 - 0 HC Test Sample Afluria
 - ...
 - Development
 - FDA spl_stylesheet_6_2
 
The spl_canada.xsl stylesheet references its siblings, spl_canada_screen.xsl, and spl_canada_i18n.xsl,
and it also relies on the templates in FDA spl_stylesheet_6_2.

2. This should be the only processing instruction referenced in the SPM XML:

<?xml-stylesheet type="text/xsl" href="../Development/spl_canada.xsl"?>

Once you change the stylesheet processing instruction in one of the SPM XML files, 
you should be able to open it in Internet Explorer or Edge, and it will transform 
and render. You may have to accept an ActiveX control to get it to work.

3. Aurora and FDA Stylesheets

We are currently using the FDA styles for styles within the drug monograph itself, and the Bootstrap
Bundle contained styles. These are similar to the styles referenced in the Aurora Design Guide, although
we are not using the actual Aurora javascript and css. The Bootstrap 4 Bundle contains the Popper library,
and we are also using the JQuery Slim version and StickyFill polyfill library.

Future plans involve creating Health Canada specific css which will replace the FDA css, and can then
be used in conjunction with the Bootstrap css and javascript. The FDA javascript is no longer needed.

These details are now out of date:

By default, the HTML for an FDA section looks like:
	<section>
		<div class="Section" data-sectionCode="TP">
		<a name="abcdef-123-guid"></a>
		<a name="section-2"></a>
		<p></p>
		<h1>Title Page</h1>
	
...and a subsection looks like
	<section>
		<div class="Section" data-sectionCode="TP-1">
		<a name="fdeacb-456-guid"></a>
		<a name="section-2.1"></a>
		<p></p>
		<h2>Sub Title</h2>

By default, the HTML for an Aurora/Boostrap section card (with no accordion) looks like:
	<div class="card">
		<div class="card-header" id="heading-abcdef-123-guid">Title Page</div>
		<div id="abcdef-123-guid" aria-labelledby="heading-abcdef-123-guid">
			<!-- Embedded FDA style section -->
			<section>
				<div class="Section" data-sectionCode="TP">
					<a name="abcdef-123-guid"></a>
					<a name="section-2"></a>
					<!-- Section Content goes here -->
				</div>
			</section>
		</div>
	</div>

Bootstrap Scrollspy requires an anchor in the navigation with a matching div or section id, and works like this:
	<body data-spy="scroll" data-target="#myScrollspy" data-offset="1">
		<div class="container-fluid">
			<div class="row">
				<nav class="col-sm-3 col-4" id="myScrollspy">
					<ul class="nav nav-pills flex-column">
						<li class="nav-item">
							<a class="nav-link active" href="#baddad">Section 1</a>
						</li>
						<li class="nav-item dropdown">
						  <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">Section 4</a>
						  <div class="dropdown-menu">
							<a class="dropdown-item" href="#abacab">Link 1</a>
							<a class="dropdown-item" href="#caffee">Link 2</a>
						  </div>
						</li>
					</ul>
				</nav>
				<div class="col-sm-9 col-8">
				  <div id="baddad" class="bg-success">    
					<h1>Section 1</h1>
					<p>Try to scroll this section and look at the navigation list while scrolling!</p>
				  </div>
				. . . 
				</div>
			</div>
		</div>
	</body>

4. Web Navigation and Responsive Design

Sidebar navigation is hidden for small screen sizes and can be used on larger screens. Sidebar
navigation and the accordion collapsing is essentially the same thing: clicking a menu item and
the corresponding accordion header have the same effect. In both cases, the behaviour is to show
or hide a section of content.

Bootstrap Scrollspy is a library which synchronizes scrolling and navigation. The navigation menu 
currently does not extend below the second level of sections.

In the current implementation, the width of the sidebar navigation has been fixed to 400px to
resolve an issue I discovered with accordion resizing. Realistically, it makes sense to fix the
sidebar navigation size to always fit the longest expected top level heading.

5. Internationalization, Labels and Local Date Formats

Internationalization and local date formatting maintained in the spl_canada_i18n.xsl transform file.
Where it is possible, Display Names should be used. Where static labels are required, these need to
be internationalized. These are necessary for any fields that are Required but not Mandatory. 