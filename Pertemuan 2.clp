(deftemplate rumah
    (slot harga)
    (slot nama)
    )

(deffacts rumah
    (rumah(nama asdasda)(harga 1000000))
 )



(facts) ;buat cetak
(reset) ;buat run deffacts sekaligus menghapus seluruh value sebelum reset
(facts)
(assert (rumah(harga 10000)(nama Rumah))) ;assert buat insert data
(assert (rumah(harga 15000)(nama Idaman)))
;(retract 1) ;buat ngapus fakta berdasarkan indeks
(facts)
(modify 1(nama lalala)(harga 1))
(facts)

(deffunction printMenu()
    
    (printout t "Menu" crlf "1.Insert" crlf "2. Update" crlf "3. Delete" crlf "4. Exit" crlf "Pilih : ")
    )

(bind ?count 2)
(bind ?menu 0)
(while (neq ?menu 4)
    (bind ?menu 0)
	(while (or(eq (numberp ?menu) FALSE)(< ?menu 1)(> ?menu 4))
	    (printMenu)
	    (bind ?menu (read))
    )
    (if(eq ?menu 1) then
        (bind ?inHarga "")
        (bind ?inNama "")
        (while (or(eq (lexemep ?inNama) FALSE)(< (str-length ?inNama) 3)(> (str-length ?inNama) 10))	              
	        (printout t "Insert nama : ")
	        (bind ?inNama (readline))
        )
	    (while (or(eq(numberp ?inHarga) FALSE)(< ?inHarga 0))
            (printout t "Insert harga : ")
        	(bind ?inHarga (read)) 
        )
        (assert (rumah(harga ?inHarga)(nama ?inNama)))
        (bind ?count ?count+1)
        (facts)
        (readline)
        
    elif(eq ?menu 2) then
        (facts)
        (bind ?index 0)
        (bind ?inHarga "")
        (bind ?inNama "")
        (while (or(< ?index 1)(> ?index ?count-1))
            (printout t "Insert index : ")
      	    (bind ?index (read))	
            )        
        (printout t "Modify harga : ")
        (bind ?inHarga (readline))
        (printout t "Modify nama : ")
        (bind ?inNama (readline))
        
        (try         	
        	(modify ?index(harga ?inHarga)(nama ?inNama))
         catch
            (printout t "Update error")
            (readline)
        )
        (facts)
        (readline)
        
        
    elif(eq ?menu 3) then
        (facts)
        (bind ?delIndex "")
        (while (or(< ?delIndex 1)(> ?delIndex ?count-1))
	        (printout t "Insert index to delete : ")
	        (bind ?delIndex (read))
        )
        (retract ?delIndex)
        (bind ?count ?count-1)
        (facts)
        (readline)
    )	
)