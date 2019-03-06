Sub Total_Stock_Volume()

'Set an initial variable for holding the ticker_name
Dim ticker_name as string

'Set an initial variable for holding total_stock_volume
Dim total_stock_volume as double
total_stock_volume = 0


'Keep track of the location for each stock brand in the summary table
Dim summary_table_row as integer
summary_table_row = 2

    'Loop through rows, 2 to 22
    For i = 2 to 70926 
    
        'Check credit stock name, if it is different...
        If Cells(i+1, 1).value <> Cells(i, 1).value then
        
            'Set stock name
            ticker_name = Cells(i, 1).value

            'Add to the total_stock_volume
            total_stock_volume = total_stock_volume + Cells(i, 7).value

            'print the ticker name in the Summary table
            Range("K" & summary_table_row).value = ticker_name

            'print the amount in the summary table
            Range("L" & summary_table_row).value = total_stock_volume

            ' Add one to the summary table row
            summary_table_row = summary_table_row + 1

            'Reset the ticker_name total
            total_stock_volume = 0

        'If the cell is the same
        Else

            'Add to the total_stock_volume
            total_stock_volume = total_stock_volume + Cells(i, 7).value '+ 1
        
        End If

    Next i

End Sub