From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 29 Oct 2012 15:27:48 +0000
Subject: Re: [lm-sensors] [PATCH v2 5/9] hwmon: (it87) Save fan registers in 2-dimensional array
Message-Id: <20121029162748.1e282a77@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351448401-13985-6-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351448401-13985-6-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 29 Oct 2012 06:49:09 -0700, Guenter Roeck wrote:
> On Mon, Oct 29, 2012 at 11:27:01AM +0100, Jean Delvare wrote:
> > has_16bit_fans() is slow so I don't like it being called at run-time.
> > That's why we had different sets of sysfs callback functions
> > originally. The change above is only acceptable because I see you'll
> > fix the performance regression in patch 8/9. Ideally you should have
> > ordered them in the other direction, but don't bother swapping them if
> > it means more work for you.
>
> I had originally introduced a flag named "has_16bit_fans" for that very purpose
> (see v2 comments above), and removed it since its only practical impact was to
> increase the size of patch 8. Easy to revert to v1 of the patch if you prefer.

No, v2 is better than v1 as long as patch 8 is going to be applied (and
it is.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
