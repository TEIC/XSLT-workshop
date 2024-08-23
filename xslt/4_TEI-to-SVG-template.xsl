<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/2000/svg"
    version="3.0">
    
    <xsl:output method="xml" indent="yes"/>
    
   <!-- ebb: This will plot an SVG that reads the Spanish linguistics letter file and outputs a value for each 
   part of speech and its percentage representation among all the words in the letter. 
   
   Input: xml/es_PS4000-TEIP5.xml
   
   Stored Output: output/letters-to-svg.svg
   -->
    
    <xsl:variable name="spanishLetter" as="document-node()" select="doc('../xml/es_PS4000-TEIP5.xml')"/>
    
    <xsl:variable name="wordCount" as="xs:integer" select="$spanishLetter//w => count()"/>
    
    <xsl:variable name="countTypes" as="xs:integer">
        <xsl:value-of select="$spanishLetter//w/@pos ! normalize-space() => distinct-values() => count()"/>
    </xsl:variable>
    
   <xsl:variable name="wordTypes" as="xs:string+" select="$spanishLetter//w/@pos ! normalize-space() => distinct-values()"/>
    
    <xsl:variable name="colors" as="xs:string+" select="'coral', 'pink', 'lavender'"/>
    
    <!--ebb: We'll plot percentages for each word type, so max Y value would be less than 100 -->
    <xsl:variable name="xSpacer" as="xs:integer" select="50"/>
    <xsl:variable name="ySpacer" as="xs:integer" select="-5"/>
    <!-- Y values go down the screen as they increase. So we relocate 0,0 down the screen and 
    plot backwards into negative space to make bars go *up*. This works best with literal calculations. 
    Just put a negative sign on an y-spacing variable to handle the drawing upwards. 
    -->
    
    <xsl:template match="/">
        <svg viewBox="0 0 600 500"> >
            
            <g transform="translate(50, 300)">
                <!-- X and Y axis lines: Line elements in SVG have a start point (x1,y1) and an endpoint (x2,y2)
                    Draw the X-axis line across the screen with x1 and x2 changing, and y1 and y2 at 0.
                    Draw the Y-axis line UP the screen (multiplying by the negative $ySpacer value), with x1 and x2 at 0.
                -->
                <line id="x-Axis" x1="0" y1="0" x2="{$countTypes * $xSpacer}" y2="0" stroke="black" stroke-width="2"/> 
                <line id="y-Axis" x1="0" y1="0" x2="0" y2="{50 * $ySpacer}" stroke="black" stroke-width="2"/> 
                <text class="y-hash" x="-30" y="{50 * $ySpacer + 5}">50%</text>
                <!-- A text label in SVG has a single x and y coordinate. -->
                <text id="title" x="100" y="{50 * $ySpacer - 20}">Proportions of Word Types in the Spanish Letter</text>
                
            
        <xsl:comment><!--ebb: A comment "scratchpad" for surveying variable values. -->
            Wordcount: <xsl:value-of select="$wordCount"/> 
            Types of words: <xsl:value-of select="$countTypes"/>
            Word types: <xsl:value-of select="string-join($wordTypes, ', ')"/>
        </xsl:comment> 
                
                <g class="wordTypeData">
                    <xsl:for-each select="$wordTypes">
                        
                        <!-- Calculate the percentage of each word type by dividing by the total word count * 100 -->
                       
                    </xsl:for-each>
                </g>
            </g>
        </svg>
      </xsl:template>
   
</xsl:stylesheet>