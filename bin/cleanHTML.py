#!/usr/bin/python
#####################################################################
# This script cleans up the html code generated by Dymola,
# and it adds the link to the style sheet
#
# MWetter@lbl.gov                                          2011-05-15
#####################################################################
import os, string, fnmatch, os.path, sys
from os import listdir
from os.path import isfile, join

def validateLine(line, filNam):
    li = ['home/mwetter', 'dymola/Modelica']
    for s in li:
        if s in line:
            print "*** Error: Invalid string '%s' in file '%s'." % (s, filNam)
# --------------------------
# Global settings
LIBHOME=os.path.abspath(".")

helpDir=LIBHOME + os.path.sep + 'help'

files = [ f for f in listdir(helpDir) if f.endswith(".html") ]

replacements = {'</head>':
               '<link rel=\"stylesheet\" type=\"text/css\" charset=\"utf-8\" media=\"all\" href=\"../Resources/www/modelicaDoc.css\">\n</HEAD>', 
               '<body><P>':
               '<body>\n<!-- --- header ------ -->\n<div class="headerStyle">\n<img src="../Resources/www/lbl-logo.png" alt="LBL logo"/>\n</div>\n<div class="headerLinks">\n<ul><li><a href="http://simulationresearch.lbl.gov/modelica">Home</a> &gt; <a href="Buildings.html">Modelica</a></li></ul>\n</div>\n<!-- --- end header -- -->\n',

               'file:////opt/dymola/Modelica/Library/Modelica 3.2/help':
               '../../msl/3.2/help',
               'file:////opt/dymola/Modelica/Library':
               '../../msl',
               '/home/mwetter/proj/ldrd/bie/modeling/github/lbl-srg/modelica-buildings/Buildings':
               '..',
               '<pre></pre>':''}
for fil in files:
    filNam = helpDir + os.path.sep + fil
    filObj=open(filNam, 'r')
    lines = filObj.readlines()
    filObj.close()
    for old, new in replacements.iteritems():
        for i in range(len(lines)):
            lines[i] = lines[i].replace(old, new)
    filObj=open(filNam, 'w')
    for lin in lines:
        # Check if line contains a wrong string
        validateLine(lin, filNam)
        filObj.write(lin)
    filObj.close()
