From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 22 Feb 2007 17:19:34 +0000
Subject: [lm-sensors] Sensors-detect with DMI detection
Message-Id: <20070222181934.524b9010.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
In-Reply-To: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ivo,

On Thu, 22 Feb 2007 15:40:18 +0100, Ivo Manca wrote:
> We are three Computer Science students from the TH Rijswijk in the
> Netherlands. Hans de Goede, our project supervisor, suggested it would be a
> good idea to work on the LM sensors detection script. After hearing his
> idea, we decided this could be a good idea and started to write a project
> plan.
> 
> Mainly, it means that the sensor-detect script will be extended with
> detection through DMI. It does not mean that the probing will be removed.
> 
> The project plan can be found at 
> http://souchi.nl/prive/ProjectPlanDMIv1.1.pdf
> Here you can find all information about our goal. We hope you think the 
> extension
> will be useful and wanted. Suggestions and feedback are always welcome.

This sounds like a good plan, however I'd like to make sure that you do
not duplicate efforts that have been going on in this area:

1* Back in November 2006, I proposed a patch to sensors-detect to print
the DMI data at the beginning of sensors-detect:
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-November/018245.html
There was zero feedback so I did not apply it, however it might be a
good base for what you want to implement now.

2* Back in September 2006, Ivan Barrera proposed something named
"sconfig" which looked very similar to your own proposal:
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-September/017623.html
Unfortunately, nobody paid attention to this, despite the fact that
everybody seems to agree that such a tool is highly needed. So maybe
you want to look at whan Ivan did and/or take contact with him.

-- 
Jean Delvare

