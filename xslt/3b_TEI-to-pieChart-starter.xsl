<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <!-- This XSLT is a starting point to output an HTML file with data formatted for a Google pie chart
    Input: xml/es_PS4000-TEIP5.xml
    
    Stored Output: output/letter-to-pieChart.html
    -->
    
    <xsl:output method="xhtml" html-version="5" indent="yes"></xsl:output>
    
   <!-- MS: and now we can reuse the same example to create a pie chart using the javascript libary Google Charts:
       https://developers.google.com/chart/interactive/docs/gallery/piechart. Notice that we need the XHTML namespace for the resulting file instead of the SVG namespace, and the output method XHTML 
   -->
    
    <!-- Load the TEI XML document you want to analyze -->
    <xsl:variable name="doc" as="document-node()"
        select="doc('../xml/es_PS4000-TEIP5.xml')"/>
    
    <!-- Select all word elements <w> that have a @pos attribute -->
    <xsl:variable name="words" select="$doc//w[@pos]"/>
    
    <!-- Count the total number of such words -->
    <xsl:variable name="total" as="xs:integer" select="count($words)"/>
    
    
    <xsl:template match="/">
        
        <!-- 
            <html>
            <head>
            <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
                <script type="text/javascript">
                    google.charts.load('current', {'packages':['corechart']});
                    google.charts.setOnLoadCallback(drawChart);
                    
                    function drawChart() {
                    
                    var data = google.visualization.arrayToDataTable([
                    
                    ['Word type', 'Percentage'],
                    
                    ['Z',0.97],['A',2.14],['R',7.96],['D',9.51],['P',10.1],['C',12.82],['S',15.53],['N',17.86],['V',20.19],
                    
                    ]);
                    
                    
                    
                    
                    var options = {
                    title: 'Proportions of Word Types in the Spanish Letter'
                    };
                    
                    var chart = new google.visualization.PieChart(document.getElementById('piechart'));
                    
                    chart.draw(data, options);
                    }
                </script>
            </head>
            <body>
                <div id="piechart" style="width: 900px; height: 500px;"></div>
            </body>
           </html>
        
        -->
        
       
      </xsl:template>
   
</xsl:stylesheet>