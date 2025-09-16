<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <!-- This XSLT outputs and HTML file with data formatted for a Google pie chart
    Input: xml/es_PS4000-TEIP5.xml
    
    Output: output/letter-to-pieChart.html
    -->
    
    <xsl:output method="xhtml" html-version="5" indent="yes"></xsl:output>
    
    
    <!-- Load the TEI XML document you want to analyze -->
    <xsl:variable name="doc" as="document-node()"
        select="doc('../xml/es_PS4000-TEIP5.xml')"/>
    
    <!-- Select all word elements <w> that have a @pos attribute -->
    <xsl:variable name="words" select="$doc//w[@pos]"/>
    
    <!-- Count the total number of such words -->
    <xsl:variable name="total" as="xs:integer" select="count($words)"/>
    
    
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Proportions of Word Types in the Spanish Letter</title>
                
                <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
                <script type="text/javascript">
                    google.charts.load('current', {'packages':['corechart']});
                    google.charts.setOnLoadCallback(drawChart);
                    
                    function drawChart() {
                    var data = google.visualization.arrayToDataTable([
                    ['Word type', 'Percentage'],
                    
                    <xsl:for-each-group select="$words" group-by="normalize-space(@pos)">
                        <xsl:sort select="count(current-group())" order="descending"/>
                        <xsl:sort select="current-grouping-key()"/>
                        
                        <xsl:variable name="count" select="count(current-group())" as="xs:integer"/>
                        <xsl:variable name="pct"   select="100 * $count div $total" as="xs:double"/>
                        
                        <xsl:text>['</xsl:text>
                        <xsl:value-of select="current-grouping-key()"/>
                        <xsl:text>', </xsl:text>
                        <xsl:value-of select="format-number($pct, '0.00')"/>
                        <xsl:text>],</xsl:text>
                    </xsl:for-each-group>
                    
                    ]);
                    
                    
                    var options = {
                    title: 'Proportions of Word Types in the Spanish Letter', <!-- MS: add the title -->
                    
                    
                    };
                    
                    var chart = new google.visualization.PieChart(document.getElementById('piechart'));
                    chart.draw(data, options);
                    }
                </script>
            </head>
            <body>
                <!-- MS: define the display area -->
                <div id="piechart" style="width: 900px; height: 500px;"></div>
            </body>
        </html>
    </xsl:template>
   
</xsl:stylesheet>