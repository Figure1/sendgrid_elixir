defmodule SendGrid.Stats do
  alias __MODULE__
  @category_stats_url "/v3/categories/stats"

  def get(start_date, end_date, group_by, categories) do
    case SendGrid.get(@category_stats_url, [], params: %{start_date: start_date, end_date: end_date, aggregated_by: group_by, categories: categories}) do
      { :ok, response = %{ status_code: status_code } } when status_code in [200] ->
        response.body
      { :ok, %{ body: body } } -> { :error, body["errors"] }
      _ -> { :error, "Unable to communicate with SendGrid API." }
    end
  end
end