Sub CreditCard()

  ' Set an initial variable for holding the brand name
  dim brand_name as string

  ' Set an initial variable for holding the total per credit card brand
  dim brand_total as double
  brand_total = 0

  ' Keep track of the location for each credit card brand in the summary table
  dim summary_table_row as integer
  summary_table_row = 2

  ' Loop through all credit card purchases
  For i = 2 to 101

    ' Check if we are still within the same credit card brand, if it is not...
    If Cells(i + i, 1).value <> Cells(i, 1).value then

      ' Set the Brand name
      brand_name = Cells(i, 1).value

      ' Add to the Brand Total
      brand_total = brand_total + Cells(i, 3).value

      ' Print the Credit Card Brand in the Summary Table
      Range("G" & Summary_Table_Row).value = brand_name

      ' Print the Brand Amount to the Summary Table
      Range("H" & Summary_Table_Row).value = brand_total

      ' Add one to the summary table row
      summary_table_row = summary_table_row + 1
      
      ' Reset the Brand Total
      brand_total = 0

    ' If the cell immediately following a row is the same brand...
    Else

      ' Add to the Brand Total
      brand_total = brand_total + Cells(i, 3).value
    
    End if

  Next i
      
End Sub
