$('<%=j render 'expense_detail', expense_detail: @expense_detail %>').appendTo('#Expense_List').hide().fadeIn()
$("#Expense_Detail_Form_new").show()

<% @expense_detail = ExpenseDetail.new %>
$("#Expense_Detail_Form").html "<%= j render 'form' %>"
$("#Expense_Detail_Form").hide()