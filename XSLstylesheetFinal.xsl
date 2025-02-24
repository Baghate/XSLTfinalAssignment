<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0">
    
    <xsl:output method="html" indent="yes"/>
    
    <!-- Page d'accueil -->
    <xsl:template match="/">
        <xsl:result-document href="out/index.html" method="html">
            <html>
                <head>
                    <link href="../encoding.css" rel="stylesheet"/>
                    <title>Encodage de correspondance entre Raymond Aron et des universitaires</title>
                </head>
                <body>
                    <!-- Navigation avec un lien vers la page d'accueil -->
                    <nav>
                        <ul>
                            <li><a href="index.html">Accueil</a></li>
                        </ul>
                    </nav>
                    <!-- Titre principal de la page -->
                    <h1>Encodage de correspondance entre universitaires</h1>
                    <!-- Description de Raymond Aron -->
                    <p>Raymond Aron est un sociologue et philosophe français, figure de proue de la droite intellectuelle du XXe siècle, anti-marxiste et libéral.</p>
                    <!-- Description du projet --><p>Le projet <xsl:value-of select="//tei:titleStmt/tei:title"/> vise à éditer la correspondance échangée entre Raymond Aron et ses collègues de la revue History and Theory.</p>
                    <ul>
                        <xsl:for-each select="//tei:div[tei:head]">
                            <li>
                                <a href="lettre_{position()}.html">
                                    <xsl:value-of select="tei:head/tei:date"/>
                                </a>
                            </li>
                        </xsl:for-each>
                    </ul>
                    <footer>
                        <p>
                            <strong>Publication Statement:</strong><br/>
                            <xsl:value-of select="//tei:publicationStmt/tei:authority"/><br/>
                            <xsl:value-of select="//tei:publicationStmt/tei:availability/tei:p"/>
                        </p>
                    </footer>
                </body>
            </html>
        </xsl:result-document>
        
        <!-- Pages individuelles pour chaque lettre -->
        <xsl:for-each select="//tei:div[tei:head]">
            <!-- Variable pour l'identifiant de la lettre -->
            <xsl:variable name="letter-id" select="position()"/>
            <xsl:result-document href="out/lettre_{$letter-id}.html" method="html">
                <html>
                    <head>
                        <!-- Lien vers la mise en forme CSS -->
                        <link href="../encoding.css" rel="stylesheet"/>
                        <title>
                            <xsl:value-of select="tei:head/tei:date"/>
                        </title>
                    </head>
                    <body>
                        <!-- Navigation avec des liens vers l'accueil et la lettre actuelle -->
                        <nav>
                            <ul>
                                <li><a href="index.html">Accueil</a></li>
                                <li><a href="lettre_{$letter-id}.html">Lettre du <xsl:value-of select="tei:head/tei:date"/></a></li>
                            </ul>
                        </nav>
                        <h1>
                            <xsl:value-of select="tei:head/tei:date"/>
                        </h1>
                        <!-- Conteneur principal pour le contenu de la lettre -->
                        <div class="container">
                            <!-- Titre de la lettre -->
                            <h2>
                                <xsl:apply-templates select="tei:head/tei:title"/>
                            </h2>
                            <!-- Adresse de la lettre -->
                            <p><xsl:value-of select="tei:head/tei:address/tei:addrLine"/></p>
                            <!-- Date de la lettre -->
                            <p><xsl:value-of select="tei:head/tei:date"/></p>
                            <!-- Contenu de l'opener -->
                            <div>
                                <xsl:apply-templates select="tei:opener"/>
                            </div>
                            <!-- Contenu principal de la lettre -->
                            <xsl:apply-templates select="tei:div"/>
                            <!-- Closing Remarks -->
                            <div class="closing-remarks">
                                <h3>Closing Remarks</h3>
                                <p><xsl:value-of select="tei:closer/tei:signed"/></p>
                            </div>
                        </div>
                        <footer>
                            <!-- Footer avec des informations de publication et de source -->
                            <p>
                                <strong>Publication Statement:</strong><br/>
                                <xsl:value-of select="//tei:publicationStmt/tei:authority"/><br/>
                                <xsl:value-of select="//tei:publicationStmt/tei:availability/tei:p"/>
                            </p>
                            <p>
                                <strong>Source Information:</strong><br/>
                                <xsl:value-of select="//tei:sourceDesc/tei:p/tei:idno"/><br/>
                                <xsl:value-of select="//tei:sourceDesc/tei:p/tei:origPlace"/>
                            </p>
                            <p>Autres lettres :</p>
                            <ul>
                                <xsl:for-each select="//tei:div[tei:head]">
                                    <li>
                                        <a href="lettre_{position()}.html">
                                            <xsl:value-of select="tei:head/tei:date"/>
                                        </a>
                                    </li>
                                </xsl:for-each>
                            </ul>
                        </footer>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Modèle pour les paragraphes -->
    <xsl:template match="tei:p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <!-- Modèle pour l'opener -->
    <xsl:template match="tei:opener">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!-- Modèle pour <term> -->
    <xsl:template match="tei:term">
        <strong>
            <xsl:apply-templates/>
        </strong>
    </xsl:template>
    
    <!-- Modèle pour <foreign> -->
    <xsl:template match="tei:foreign">
        <em>
            <xsl:apply-templates/>
        </em>
    </xsl:template>
    
    <!-- Modèle pour <hi> -->
    <xsl:template match="tei:hi">
        <u>
            <xsl:apply-templates/>
        </u>
    </xsl:template>
    
    <!-- Modèle pour <persName> dans <title> -->
    <xsl:template match="tei:title/tei:persName">
        <span style="font-size: smaller; display: block; margin-top: 0.5em; font-weight: normal;">
            <xsl:text>Members of the editorial committee: </xsl:text>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- Modèle pour <affiliation> dans <title> -->
    <xsl:template match="tei:title/tei:affiliation">
        <span style="display: block; margin-bottom: 0.5em;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
</xsl:stylesheet>