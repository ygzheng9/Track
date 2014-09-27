$("#<%= dom_id @expense_detail %>").replaceWith("<%= j render 'expense_detail', expense_detail: @expense_detail %>")
$("#Expense_Detail_Form_new").show()

<% @expense_detail = ExpenseDetail.new %>
$("#Expense_Detail_Form").html("<%= j render 'form' %>")
$("#Expense_Detail_Form").hide()