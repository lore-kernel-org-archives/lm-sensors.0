From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 18 Feb 2012 21:46:38 +0000
Subject: Re: [lm-sensors] help with setup / chip support
Message-Id: <20120218224638.3477c23b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAP4ecBN-YdCqfetiJG2-o_SW8kEWcXNFA2eSQRQNvT7LsRHGog@mail.gmail.com>
In-Reply-To: <CAP4ecBN-YdCqfetiJG2-o_SW8kEWcXNFA2eSQRQNvT7LsRHGog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Kenneth,

On Fri, 17 Feb 2012 16:36:36 -0800, Kenneth Cox wrote:
> On Thu, Feb 16, 2012 at 11:35 PM, Jean Delvare <khali@linux-fr.org> wrote:
> > Did you restart the lm_sensors service after that? sensors-detect only
> > detects which drivers are needed, it doesn't load them for you.
> 
> How do you restart lm_sensors? I just rebooted and assumed that would
> restart it ok.

Depends on your distribution:
# rclm_sensors restart
would work on Suse unless you use systemd in which case it would rather
be:
# systemctl restart lm_sensors.service
Red Hat / Fedora is probably similar, while Debian and Ubuntu are
certainly different. Can't help you with these as I don't know them,
sorry.

Also note that most distributions modify sensors-detect slightly to
improve the integration. As you're using the upstream version of
sensors-detect you may be missing part of this integration.

Rebooting should work too, so if you did that, there's certainly
another problem.

> > If you still don't get more values even after that, check the kernel
> > log for error messages.
> 
> I don't know what I'm looking for in the kernel log. I searched the log for
> "sensors" and came up with nothing. What should I be looking for?

You should rather look for "w83627" and "nct67":

# dmesg | grep -i w83627
# dmesg | grep -i nct67
or
# grep -i w83627 /var/log/messages | tail
# grep -i nct67 /var/log/messages | tail

Most likely you are the victim of an ACPI resource conflict, this is
becoming very frequent and sensors-detect doesn't know about them yet.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
