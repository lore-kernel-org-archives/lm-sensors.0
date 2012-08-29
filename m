From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 29 Aug 2012 16:58:07 +0000
Subject: Re: [lm-sensors] Monitoring FPGA
Message-Id: <20120829165807.GA28158@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CANZCtCz9NKCK1vNPjuRFqwrmyBzb9aehi0OQDZ-=K47==h8JCw@mail.gmail.com>
In-Reply-To: <CANZCtCz9NKCK1vNPjuRFqwrmyBzb9aehi0OQDZ-=K47==h8JCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Aug 29, 2012 at 08:27:25PM +0530, Rakesh Kumar wrote:
> Hello I am Rakesh. I want to know if there are any vendor provided library
> APIs to query FPGA utilization, health, temperature etc. from the
> application level for developers. I am a student and I am planning to
> develop an FPGA monitoring tool in a heterogeneous Linux cluster. Or if I
> have to start everything from scratch what is the procedure? Does lm
> sensors help me with this? I look forward to hearing from you. Thank you.
> Please send a mail to knrakeshkumar@gmail.com

Hi,

first of all, the functionality you are looking for depends on the FPGA
supporting system monitor features. Those will be FPGA specific. Also,
the functionality has to be enabled in the FPGA design. For example,
the Virtex-5 FPGAs support system monitor functionality, but it has to be
enabled by including the SYSMON functional block into the actual design.
In addition to that, the SYSMON registers have to be exposed to the user.
This again is design specific.

Ultimately, that means that a generic solution to monitor the health of FPGAs is
likely technically impossible, since there are several layers of dependency. I
could imagine something like a generic hwmon driver for the SYSMON functional
block of Virtex-5 FPGAs, as a slave driver to an FPGA MFD driver. But that would
require an actual design to be able to test the code, and it would only apply to
one specific class of FPGAs.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
