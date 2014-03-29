show: clean report1.pdf img/scatter_points.png
	cp img/scatter_points.png  ~/public_html/uml1/scatter.png
	cp report1.pdf ~/public_html/uml1/report1.pdf
	chmod -R a+x ~/public_html/uml1
	chmod a+r ~/public_html/uml1/report1.pdf

report1.pdf: report1.tex	
	pdflatex report1

clean:
	rm -f *.aux *.log *~ *.pdf
