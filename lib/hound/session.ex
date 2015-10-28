defmodule Hound.Session do
  @moduledoc "Low-level session functions internally used by Hound, to work with drivers. See Hound.Helpers.Session for session helpers"

  import Hound.RequestUtils

  @doc "Get server's current status"
  @spec server_status() :: Dict.t
  def server_status() do
    make_req(:get, "status")
  end


  @doc "Get list of active sessions"
  @spec active_sessions() :: Dict.t
  def active_sessions() do
    make_req(:get, "sessions")
  end


  @doc "Creates a session associated with the current pid"
  @spec create_session(String.t) :: String.t
  def create_session(browser_name) do
    params = %{
      desiredCapabilities: %{
        javascriptEnabled: true,
        version: "",
        rotatable: true,
        takesScreenshot: true,
        cssSelectorsEnabled: true,
        browserName: browser_name,
        nativeEvents: true,
        platform: "ANY"
      }
    }

    # No retries for this request
    make_req(:post, "session", params)
  end


  @doc "Get capabilities of a particular session"
  @spec session_info(String.t) :: Dict.t
  def session_info(session_id) do
    make_req(:get, "session/#{session_id}")
  end


  @doc "Destroy a session"
  @spec destroy_session(String.t) :: :ok
  def destroy_session(session_id) do
    make_req(:delete, "session/#{session_id}")
  end


  @doc "Set the timeout for a particular type of operation"
  @spec set_timeout(String.t, String.t, Integer.t) :: :ok
  def set_timeout(session_id, operation, time) do
    make_req(:post, "session/#{session_id}/timeouts", %{type: operation, ms: time})
  end

end
