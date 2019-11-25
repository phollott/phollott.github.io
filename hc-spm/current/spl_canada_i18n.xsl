<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:my="my:my" exclude-result-prefixes="my">
	<my:texts>
		<!-- English Labels -->
		<tableOfContents lang="en">TABLE OF CONTENTS</tableOfContents>
		<productDetails lang="en">PRODUCT DETAILS</productDetails>
		<companyDetails lang="en">COMPANY DETAILS</companyDetails>
		<productInfo lang="en">Product Information</productInfo>
		<brandName lang="en">Brand Name</brandName>
		<nonPropName lang="en">Non-Proprietary Name</nonPropName>
		<din lang="en">Drug Identification Number</din>
		<adminRoute lang="en">Route of Administration</adminRoute>
		<dosageForm lang="en">Dosage Form</dosageForm>
		<activeIngredients lang="en">Active Ingredient/Active Moiety</activeIngredients>
		<inactiveIngredients lang="en">Inactive Ingredients</inactiveIngredients>
		<ingredientName lang="en">Ingredient Name</ingredientName>
		<strength lang="en">Strength</strength>
		<basisOfStrength lang="en">Basis of Strength</basisOfStrength>
		<noActiveFound lang="en">No Active Ingredients Found</noActiveFound>
		<noInactiveFound lang="en">No Inactive Ingredients Found</noInactiveFound>
		<productType lang="en">Product Type</productType>
		<productCharacteristics lang="en">Product Characteristics</productCharacteristics>
		<color lang="en">Colour</color>
		<shape lang="en">Shape</shape>
		<score lang="en">Score</score>
		<imprint lang="en">Imprint</imprint>
		<flavor lang="en">Flavour</flavor>
		<combinationProduct lang="en">Combination Product</combinationProduct>
		<pharmaStandard lang="en">Pharmaceutical Standard</pharmaStandard>
		<schedule lang="en">Schedule</schedule>
		<therapeuticClass lang="en">Therapeutic Class</therapeuticClass>
		<!-- French Labels -->
		<tableOfContents lang="fr">(francais) TABLE OF CONTENTS</tableOfContents>
		<productDetails lang="fr">(francais) PRODUCT DETAILS</productDetails>
		<companyDetails lang="fr">(francais) COMPANY DETAILS</companyDetails>
		<productInfo lang="fr">(francais) Product Information</productInfo>
		<brandName lang="fr">(francais) Brand Name</brandName>
		<nonPropName lang="fr">(francais) Non-Proprietary Name</nonPropName>
		<din lang="fr">(francais) Drug Identification Number</din>
		<adminRoute lang="fr">(francais) Route of Administration</adminRoute>
		<dosageForm lang="fr">(francais) Dosage Form</dosageForm>
		<activeIngredients lang="fr">(francais) Active Ingredient/Active Moiety</activeIngredients>
		<inactiveIngredients lang="fr">(francais) Inactive Ingredients</inactiveIngredients>
		<ingredientName lang="fr">(francais) Ingredient Name</ingredientName>
		<strength lang="fr">(francais) Strength</strength>
		<basisOfStrength lang="fr">(francais) Basis of Strength</basisOfStrength>
		<noActiveFound lang="fr">(francais) No Active Ingredients Found</noActiveFound>
		<noInactiveFound lang="fr">(francais) No Inactive Ingredients Found</noInactiveFound>
		<productType lang="fr">(francais) Product Type</productType>
		<productCharacteristics lang="fr">(francais) Product Characteristics</productCharacteristics>
		<color lang="fr">(francais) Colour</color>
		<shape lang="fr">(francais) Shape</shape>
		<score lang="fr">(francais) Score</score>
		<imprint lang="fr">(francais) Imprint</imprint>
		<flavor lang="fr">(francais) Flavour</flavor>
		<combinationProduct lang="fr">(francais) Combination Product</combinationProduct>
		<pharmaStandard lang="fr">(francais) Pharmaceutical Standard</pharmaStandard>
		<schedule lang="fr">(francais) Schedule</schedule>
		<therapeuticClass lang="fr">(francais) Therapeutic Class</therapeuticClass>
	</my:texts>
	<xsl:variable name="labels" select="document('')/*/my:texts"/>
	
	<!-- global templates like date formatting may be specialized for different regions -->
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