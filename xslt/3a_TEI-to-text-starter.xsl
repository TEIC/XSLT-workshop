<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <xsl:output method="text"/>
    
    <!-- Load the TEI XML document you want to analyze -->
    <xsl:variable name="doc" as="document-node()" select=""/>
    
    <!-- Select all word elements <w> that have a @pos attribute -->
    <xsl:variable name="words" select=""/>
    
    <!-- Count the total number of such words -->
    <xsl:variable name="total" as="xs:integer" select=""/>
    
    <xsl:template match="/">
        <!-- Print CSV header line -->
        <xsl:text>wordType,percentage</xsl:text>
        <xsl:text>&#x0A;</xsl:text>
        
        <!-- That is what our result should look like:
             
                wordType,percentLabel
                Z,0.97
                A,2.14
                R,7.96
                D,9.51
                P,10.1
                C,12.82
                S,15.53
                N,17.86
                V,20.19-->
        
        <!-- Group words by their @pos value -->
        <xsl:for-each-group select="" group-by="">
            <!-- Sort by group size descending -->
            <xsl:sort select="" order="descending"/>
            
            <!-- Number of words in this group -->
            <xsl:variable name="count" select="" as="xs:integer"/>
            
            <!-- Percentage of total words in this group.  For each word type, return a percentage based on its count divided by the total word count * 100. -->
            <xsl:variable name="pct" select="" as="xs:double"/>
            
            <!-- Output CSV row: POS tag, percentage -->
            <xsl:value-of select=""/>
            <xsl:text>,</xsl:text>
            <xsl:value-of select=""/>
            <xsl:text>&#x0A;</xsl:text>
        </xsl:for-each-group>
    </xsl:template>
</xsl:stylesheet>