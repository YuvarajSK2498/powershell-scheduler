$urls = @(
    "https://dev.onehermes.net/"
    "https://upskillmeet.com/"
    "https://ublisyoga-dashboard.brightoncloudtech.com/"
    "https://raisusa.onehermes.net/"
    "https://dev-1.onehermes.net"
)
foreach ($url in $urls) {
    try {
        $response = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 30 -ErrorAction Stop
        $statusCode = $response.StatusCode
    } catch {
        if ($_.Exception.Response) {
            $statusCode = $_.Exception.Response.StatusCode.Value__
        } else {
            $statusCode = "Connection Failed"
        }
    }
    if ($statusCode -ne 200) {
        $subject = "ALERT: $url returned status $statusCode"
        $body = "The application at $url is unreachable or returned HTTP status $statusCode instead of 200."
        $securePassword = ConvertTo-SecureString "xhfi hrgl sqnv wzai" -AsPlainText -Force
        $credential = New-Object System.Management.Automation.PSCredential("brightcloudtechnology.suppport@gmail.com", $securePassword)
        $SendMailMessageParams = @{
            From       = "brightcloudtechnology.suppport@gmail.com"
            To         = "brightcloudtechnology.suppport@gmail.com"
            Subject    = $subject
            Body       = $body
            SmtpServer = "smtp.gmail.com"
            Port       = 587
            UseSsl     = $true
            Credential = $credential
        }
         Send-MailMessage @SendMailMessageParams
    }
}
