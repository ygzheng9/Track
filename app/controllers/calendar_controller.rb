class CalendarController < ApplicationController
  def index

    @expenses = ExpenseDetail.all
    @expenses_by_date = @expenses.group_by(&:today)

    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end
end
