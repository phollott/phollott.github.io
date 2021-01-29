<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:my="my:my" exclude-result-prefixes="my">
	<my:texts>
		<!-- English Labels -->
		<tableOfContents lang="en">TABLE OF CONTENTS</tableOfContents>
		<tocBoilerplate lang="en">Sections or subsections that are not applicable at the time of authorization are not listed.</tocBoilerplate>
		<productDetails lang="en">PRODUCT DETAILS</productDetails>
		<companyDetails lang="en">COMPANY DETAILS</companyDetails>
		<labeler lang="en">Market Authorization Holder</labeler>
		<registrant lang="en">Canadian Importer/Distributor</registrant>
		<partyAddress lang="en">Contact Address</partyAddress>
		<partyAdditional lang="en">Additional Contact Information</partyAdditional>
		<partyEmail lang="en">Email</partyEmail>
		<partyTel lang="en">Tel</partyTel>
		<partyWeb lang="en">Web</partyWeb>
		<product lang="en">Product</product>
		<productInfo lang="en">Product Information</productInfo>
		<brandName lang="en">Brand Name</brandName>
		<nonPropName lang="en">Non-Proprietary Name</nonPropName>
		<din lang="en">Drug Identification Number (DIN)</din>
		<adminRoute lang="en">Route of Administration</adminRoute>
		<dosageForm lang="en">Dosage Form</dosageForm>
		<activeIngredients lang="en">Active Ingredient/Active Moiety</activeIngredients>
		<inactiveIngredients lang="en">Inactive Ingredients</inactiveIngredients>
		<ingredientName lang="en">Ingredient Name</ingredientName>
		<strength lang="en">Strength</strength>
		<basisOfStrength lang="en">Basis of Strength</basisOfStrength>
		<productType lang="en">Product Type</productType>
		<productCharacteristics lang="en">Product Characteristics</productCharacteristics>
		<color lang="en">Colour</color>
		<shape lang="en">Shape</shape>
		<score lang="en">Score</score>
		<size lang="en">Size</size>
		<imprint lang="en">Imprint</imprint>
		<flavor lang="en">Flavour</flavor>
		<combinationProduct lang="en">Combination Product Type</combinationProduct>
		<pharmaStandard lang="en">Pharmaceutical Standard</pharmaStandard>
		<schedule lang="en">Schedule</schedule>
		<therapeuticClass lang="en">Therapeutic Class</therapeuticClass>
		<packaging lang="en">Packaging Status</packaging>
		<itemCode lang="en">Package Identifier</itemCode>
		<packageDescription lang="en">Package Description</packageDescription>
		<packageRegStatus lang="en">Package Available</packageRegStatus>
		<productRegStatus lang="en">Product Regulatory Status</productRegStatus>
		<approvalDate lang="en">Date of Approval</approvalDate>
		<cancellationDate lang="en">Date of Cancellation</cancellationDate>
		<marketingInfo lang="en">Product Status</marketingInfo>
		<marketingCategory lang="en">Regulatory Activity Type</marketingCategory>
		<applicationNumber lang="en">Control Number</applicationNumber>
		<partQuantity lang="en">Quantity of Parts</partQuantity>
		<partNumber lang="en">Part #</partNumber>
		<part lang="en">Part </part>
		<pkgQuantity lang="en">Package Quantity</pkgQuantity>
		<ttlProdQty lang="en">Total Product Quantity</ttlProdQty>
		<inConnective lang="en"> in </inConnective>
		<andConnective lang="en"> and </andConnective>
		<ofConnective lang="en"> of </ofConnective>
		<toConnective lang="en"> - </toConnective>

		<!-- French Labels -->
	<xsl:variable name="labels" select="document('')/*/my:texts"/>
		
	<!-- global templates like date and string cd formatting may be specialized for different regions -->
	<xsl:template name="string-lowercase">
		<!--** Convert the input text that is passed in as a parameter to lower case  -->
		<xsl:param name="text"/>
		<xsl:value-of select="translate($text,
			'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 
			'abcdefghijklmnopqrstuvwxyz')"/>
	</xsl:template>
	<xsl:template name="string-uppercase">
		<!--** Convert the input text that is passed in as a parameter to upper case  -->
		<xsl:param name="text"/>
		<xsl:value-of select="translate($text,
			'abcdefghijklmnopqrstuvwxyz', 
			'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
	</xsl:template>
	<xsl:template name="string-to-date">
		<xsl:param name="text"/>
		<xsl:param name="displayMonth">true</xsl:param>
		<xsl:param name="displayDay">true</xsl:param>
		<xsl:param name="displayYear">true</xsl:param>
		<xsl:param name="delimiter">-</xsl:param>
		<xsl:if test="string-length($text) > 7">
			<xsl:variable name="year" select="substring($text,1,4)"/>
			<xsl:variable name="month" select="substring($text,5,2)"/>
			<xsl:variable name="day" select="substring($text,7,2)"/>
			<xsl:if test="$displayYear = 'true'">
				<xsl:value-of select="$year"/>
				<xsl:value-of select="$delimiter"/>
			</xsl:if>
			<xsl:if test="$displayMonth = 'true'">
				<xsl:value-of select="$month"/>
				<xsl:value-of select="$delimiter"/>
			</xsl:if>
			<xsl:if test="$displayDay = 'true'">
				<xsl:value-of select="$day"/>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	
</xsl:transform>
