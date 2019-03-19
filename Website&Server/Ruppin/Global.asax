<%@ Application Language="C#" %>
<%@ Import Namespace="BAL" %>
<%@ Import Namespace="BEL" %>
<%@ Import Namespace="System.Threading.Tasks" %>

<script RunAt="server">
    
    static System.Timers.Timer checkUpcommingLecturesTimer = new System.Timers.Timer();
    static System.Timers.Timer sendNotificationsTimer = new System.Timers.Timer();
    static List<Letter> lettersToSend = new List<Letter>();
    

    void Application_Start(object sender, EventArgs e)
    {
        // Code that runs on application startup
        StartCheckUpcommingLecturesTimer();
    }

    void CheckUpcommingLectures(object sender, EventArgs e)
    {
        lettersToSend = Operations.CheckUpcommingLectures();
        if (lettersToSend.Count > 0)
        {
            StartSendNotificationsTimer();
        }
    }

    void SendNotifications(object sender, EventArgs e)
    {
        if (lettersToSend.Count > 0)
        {
            Letter letterToSend = lettersToSend[0];
            lettersToSend.RemoveAt(0);
            ExpoPushHelper.SendPushNotification(letterToSend.Token, letterToSend.Title, letterToSend.Body);
        }
        else
        {
            EndSendNotificationsTimer();
        }
    }

    public void StartCheckUpcommingLecturesTimer()
    {
        checkUpcommingLecturesTimer.Interval = 60000;
        checkUpcommingLecturesTimer.Elapsed += CheckUpcommingLectures;
        checkUpcommingLecturesTimer.Enabled = true;
    }

    public void StartSendNotificationsTimer()
    {
        sendNotificationsTimer.Interval = 50;
        sendNotificationsTimer.Elapsed += SendNotifications;
        sendNotificationsTimer.Enabled = true;
    }
    
    public void EndCheckUpcommingLecturesTimer()
    {
        checkUpcommingLecturesTimer.Enabled = false;
    }

    public void EndSendNotificationsTimer()
    {
        sendNotificationsTimer.Enabled = false;
    }

    void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown
        EndCheckUpcommingLecturesTimer();
        EndSendNotificationsTimer();
    }

    void Application_Error(object sender, EventArgs e)
    {
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e)
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e)
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.
        EndCheckUpcommingLecturesTimer();
        EndSendNotificationsTimer();
    }

</script>
