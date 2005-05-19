From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:24 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <3FB18CDD.D3BE9E3E@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

cool.
you still don't know which systems have 24RF08's in them, though, do
you?

tested new sensors-detect on 4 machines.
2 w/ ACPI+DMI worked fine.
One with neither (iopener) gave the standard Thinkpad warning at the
beginning.
On my HP ia64 machine it didn't give any ACPI or DMI info but didn't
give
the Thinkpad warning either... what's up with that?

Jean Delvare wrote:
> 
> > Modified Files:
> >       sensors-detect
> > Log Message:
> > (Khali) Add VPD method to detect IBM systems. In the long term, the
> > other methods (DMI and ACPI) are expected to become unnecessary.
> 
> I implemented this according to the document Pam Huntley pointed out
> several months ago:
>   http://www.pc.ibm.com/qtechinfo/MIGR-45120.html
> 
> I should have done that times ago but never found the time to do so.
> Some weeks ago I implemented it in C for integration to the dmidecode
> project, and I converted the code to Perl today.
> 
> This detection method is expected to supersede the two other ones we had
> until today (DMI and ACPI). Three significant advantages:
> 1* Detection will be more simple with a single method.
> 2* We won't rely on dmidecode anymore.
> 3* VPD is more precise and efficient since it's aimed at IBM systems.
>    We'll be able to start a blacklist and/or a whitelist.
> 
> I'd appreciate some of you give a try to sensors-detect now. If the VPD
> detection method if confirmed to work, I'll drop the other two methods
> soon.
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
