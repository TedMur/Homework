Sub stock()

Dim ticker_name as string
Dim ticker_total as double
ticker_total = 0

Dim ticker_table_row as long
ticker_table_row = 2

lastrow = Cells(Rows.Count, 1).End(xlUp).Row

    'Loop through all stock data
    For i = 2 to lastrow

        'Check stock_name, if it is not...
        If Cells(i + 1, 1).value <> Cells(i, 1).value then

            'Set stock_name
            stock_name = Cells(i, 1).value

            'Set total_volume
            total_volume = total_volume + Cells(i, 7)

            'Print stock_name to the summary table
            Range("I" & summary_table_row).value = stock_name

            'Print total_volume to the summary table
            Range("L" & summary_table_row)

            'Add one to summary table row
            summary_table_row = summary_table_row + 1

            'Reset the total_volume
            total_volume = 0

        'If the cell immediately following a row is the same brand...
        Else
        
            'Add to the total_volume
            total_volume = total_volume + Cells(i, 7).value
        
        End If

    Next i

End Sub










'* Yearly change from what the stock opened the year at to what the closing price was.

'* The percent change from the what it opened the year at to what it closed.





'* You should also have conditional formatting that will highlight positive change in green and negative change in red.
