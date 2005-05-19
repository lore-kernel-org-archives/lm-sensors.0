From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: lm_sensors on IBM systems
Message-Id: <3FC8D12F.E742F394@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We're working on a method to identify the systems that have the 24RF08
eeprom in them
so that we don't have to blacklist all IBM systems.
In the meantime, you may wish to verify that your system does not have
this chip
(look at the board, read server docs). While you're at it try to
identify
what chips are on the board that our package supports (see our FAQ too).
Then, if you are brave, edit the sensors-detect program
to bypass the check (you're in a sysadmin course, should be easy for
you...)
and try again. You should read the README.thinkpad file carefully first.
No promises that it won't destroy the server though.
Call it a learning experience.
And if it works you'll have a better report.


cst01074@cs.camosun.bc.ca wrote:
> 
> To whom it may concern,
> 
> I am a student at Camosun College in Victoria, B.C.. As a project for a RedHat Linux System Admin
> course that I am currently taking, my partner and I were given the task of installing (or trying
> to install) "lmsensors". Our instructor had made a previous attempt without success, and was not
> really expecting us to succeed, but to gain experience in the process. Our instructor has
> "lmsensors" running  on a few of his own (non-IBM) machines successfully. He was aware of the
> obstacles that we would encounter as well. Although we would have liked to have proven him wrong,
> we too were unsuccessful.We are running an IBM Xseries 305 server, with multiple IBM NetVista Type
> 6794-11U subservers all running on Redhat 9 platforms. We encountered the following message during
> our installation attempt, and were forced to resign our attempt. Unfortunately, we will also have
> to make the focus of our oral report on hardware compatibility issues and the effect that they
> have on future purchasing decisions. Are you aware of a patch for IBM machines that can be used
> with "lmsensors" so that future students may be more successful than we were? If so, we would be
> happy to pass this on to our instructor. The Open Source Community has suggested that they would
> be willing to write the patches if the necessary API's were made available.Is that a possibility
> for the future?
> 
> Thanks in advance for any assistance that you may be able to provide.
> 
> This is a printout of the fail message that we encountered.
> 
> BIOS vendor (ACPI): PTLTD
>  System vendor (DMI): IBM
>  BIOS version (DMI): 20KT34AUS
>  Sorry, we won't let you go on. IBM systems are known to have
>  serious problems with lm_sensors, resulting in hardware failures.
>  For more information, see README.thinkpad or
>  http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/README.thinkpad.
>  We used two methods to determine your system's vendor, and they led
>  to different results. We'd appreciate to have feedback about such
>  systems. Please, take some time and contact the lm_sensors mailing
>  list at <sensors@stimpy.netroedge.com>.
>  We need the following information:
>   * The brand and model of your system
>   * The BIOS vendor (ACPI) displayed above
>   * The System vendor (DMI) displayed above
>  Thanks!
> 
> Thanks again,
> Brad and Tim
