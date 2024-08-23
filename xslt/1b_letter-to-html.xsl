<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
<!-- 2022-07-24 ebb: This XSLT is designed to read a collection of XML files. 
        It will output a separate HTML file for each TEI XML letter in our letters folder. 
        You can run it in the XSLT debugger view by selecting any xml-formatted file at all as the XML source.
        
        Stored output: output/html-letters
    -->
    
<!-- ebb: Uncomment if processing only one file, and remove the xsl:for-each in the template match on `/`. 
        <xsl:output method="xhtml" html-version="5" indent="yes"/>-->
   
    
    <xsl:variable name="letters" as="document-node()+" select="collection('../xml/?select=*.xml')"/>
    
    <xsl:template match="/">
       <xsl:for-each select="$letters"> 
           <xsl:variable name="filename" as="xs:string" select="base-uri() ! tokenize(., '/')[last()] ! substring-before(., '.xml')"/>
           <xsl:result-document method="xhtml" html-version="5" indent="yes" href="../output/html-letters/{$filename}.html">
           <!-- ebb: In the lines above, we create an xsl:for-each statement that looks at 
           each file in the XML letters colection in turn. We set a variable that returns its filename, and 
           then we use that in xsl:result-document, which outputs a new HTML file in the folder we designate.
           -->
           <html>
            <head>
                <title><xsl:apply-templates select="//titleStmt/title" /></title>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
            </head>
            <body>

              <!--Here we begin to "push process" the letter contents: -->  
                <section id="letter">
                    <xsl:apply-templates select="//text/body"/>
                </section>
            </body>
        </html>
           </xsl:result-document>
       </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="div">
        <div>
            <xsl:apply-templates />
        </div>
    </xsl:template>
    
    <xsl:template match="p | opener | closer">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

 <!-- ebb: In the following two templates, we apply some CSS color highlighting to proper names, 
     OR to nouns with determiners (in the Spanish letter) using the HTML <em> element and  @style attribute.
     The "or" pipes make it possible for XSLT to process these different kinds of nodes in the same rule. 
 -->   
    <xsl:template match="*[@ref] | *[@corresp] | w[@pos='N']">
        <em style="color:red;">
            <xsl:apply-templates />
        </em>
    </xsl:template>
    
    <xsl:template match="w[@pos='D'][following-sibling::w[1][@pos='N']]">
        <em style="color:blue;"><xsl:apply-templates/></em>
    </xsl:template>
    
    <xsl:template match="lb">
        <br/>
    </xsl:template>
    
    <xsl:template match="figure"/>
    <xsl:template match="note" />
    <!--ebb: The two templates above are suppressing elements from being output. -->
    
    <xsl:template match="choice">
       <xsl:apply-templates select="orig | abbr"/>
    </xsl:template>
    
    
   <xsl:template match="TEI[@xml:lang='ja']//text()">
        <xsl:value-of select="normalize-space(.)"/>
    </xsl:template>
    <!-- kn ebb ms: This template is necessary for proper space-handling of Japanese text output. 
    For elaboration, process the Japanese letter file with and without this template, look at the 
    output view as code, and search for spaces. Japanese literation should not include spacing between words. -->
    
</xsl:stylesheet>