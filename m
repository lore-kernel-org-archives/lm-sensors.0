From: Markus Fischer <markus@fischer.name>
Date: Tue, 15 Jun 2010 19:52:10 +0000
Subject: Re: [lm-sensors] Getting sensor information from HP ProLiant DL360
Message-Id: <4C17D9EA.7030303@fischer.name>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C178641.2050903@fischer.name>
In-Reply-To: <4C178641.2050903@fischer.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 15.06.2010 18:59, Juerg Haefliger wrote:
> For HP servers, use the hplog tool that is part of the hp-health
> package which you can get from hp.com.

Great tip, wasn't aware of that!

After some try and error I came across
http://downloads.linux.hp.com/SDR/getting_started.html , downloaded
http://downloads.linux.hp.com/SDR/downloads/bootstrap.sh (had to install
lbs-version to get it running), it installed the additional sources.list
files and I was able to install the packages hp-health and hp-snmp-agents.

thank you very much!
- Markus

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
