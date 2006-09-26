From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 26 Sep 2006 17:16:15 +0000
Subject: [lm-sensors] SVN/trac requests
Message-Id: <20060926191615.4fb82396.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060926140502.00d29dd5.khali@linux-fr.org>
In-Reply-To: <20060926140502.00d29dd5.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting myself:
> Another option is to give the users a simple svn command to type to
> retrieve just that file:
>   svn export http://lm-sensors.org/svn/lm-sensors/trunk/prog/detect/sensors-detect
> 
> However it is significantly less convenient, as the user might not have
> svn installed. Or maybe we can install a simple CGI script on the web
> server which would run this command and return the result to the
> user? I can't seem to find an option to output the file to stdout
> though, which we would need.

Ah, it appears that "svn cat" does just that, so it could actually work.

-- 
Jean Delvare

