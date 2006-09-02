From: greg@kroah.com (Greg KH)
Date: Sat, 02 Sep 2006 18:27:08 +0000
Subject: [lm-sensors] TODO: "dynamic" sysfs callbacks
Message-Id: <20060902182708.GA31197@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44F1E5B6.1080105@gmail.com>
In-Reply-To: <44F1E5B6.1080105@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Sep 02, 2006 at 04:24:01PM +0200, Jean Delvare wrote:
> I don't have the time to even try measuring it. I just thought I would
> mention performance in the conversation, after I noticed with a user
> some days ago that logging sensors data using "sensors" every other
> second would put 15% of load on the system, while I expected it
> to be unnoticeable.

This is probably just due to an interruptable sleep happening, which
artificially increases the load average.  I would be supprised if the
CPU usage really goes up by that much.

thanks,

greg k-h

