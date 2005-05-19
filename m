From: william@wschnell.ca (william)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: temperatures
Message-Id: <opr9rojysdy8z6pj@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <opr9pzmdztlsrnb1@localhost>
In-Reply-To: <opr9pzmdztlsrnb1@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Yes!
It works, and I have temperatures, and the usual alarms.
I put the modprobe lines in rc.local, as it was less cluttered.
Both rc.local and rc.modules are shell scripts in slack9.1.

Should I be concerned about the alarms? Have checked in BIOS, and the  
voltages seem accurate.

Thanks much, folks.

William



On Thu, 17 Jun 2004 15:42:56 +0200 (CEST), Rudolf Marek  
<R.Marek@sh.cvut.cz> wrote:

>
>

> Hello,
>
>
> Step 1:
> Do you know the module names?
>
> If not, just after sensors-detect exits there is written what modules
> should be inserted for your system. You need to edit /etc/rc.d/rc.modules
> Its a text file, writable by root.
>
> lines are like
>
> #this is comment
> modprobe some_module_name
>
