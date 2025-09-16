<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <xsl:output method="text"/>
    
    <!-- Load the TEI XML document you want to analyze -->
    <xsl:variable name="doc" as="document-node()"
        select="doc('../xml/es_PS4000-TEIP5.xml')"/>
    
    <!-- Select all word elements <w> that have a @pos attribute -->
    <xsl:variable name="words" select="$doc//w[@pos]"/>
    
    <!-- Count the total number of such words -->
    <xsl:variable name="total" as="xs:integer" select="count($words)"/>
    
    <xsl:template match="/">
        <!-- Print CSV header line -->
        <xsl:text>wordType,percentage</xsl:text>
        <xsl:text>&#x0A;</xsl:text>
        
        <!-- Group words by their @pos value -->
        <xsl:for-each-group select="$words" group-by="normalize-space(@pos)">
            <!-- Sort by group size descending -->
            <xsl:sort select="count(current-group())" order="descending"/>
            
            <!-- Number of words in this group -->
            <xsl:variable name="count" select="count(current-group())" as="xs:integer"/>
            
            <!-- Percentage of total words in this group -->
            <xsl:variable name="pct" select="100 * $count div $total" as="xs:double"/>
            
            <!-- Output CSV row: POS tag, percentage -->
            <xsl:value-of select="current-grouping-key()"/>
            <xsl:text>,</xsl:text>
            <xsl:value-of select="format-number($pct, '0.00')"/>
            <xsl:text>&#x0A;</xsl:text>
        </xsl:for-each-group>
    </xsl:template>
</xsl:stylesheet>

