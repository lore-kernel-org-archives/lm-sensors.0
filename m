From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 16 Oct 2008 14:52:34 +0000
Subject: Re: [lm-sensors] Patch: fschmd-watchdog-v2.patch
Message-Id: <20081016165234.43312f22@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <487F4DDE.7040909@hhs.nl>
In-Reply-To: <487F4DDE.7040909@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Thu, 16 Oct 2008 16:02:22 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > As a side note, I wonder if it would make sense to have a separate lock
> > for the watchdog struct members. fschmd_update_device() can hold
> > data->update_lock for a significant amount of time, and you probably
> > don(t want to delay watchdog_timer() too much.
> > 
> 
> Hmm, question: can one do multiple i2c_smbus_read/write_byte_data() requests 
> and will the i2c core then do locking to serialize requests?

Yes, i2c-core serializes transaction requests that go to each i2c
adapter, using the i2c_adapter->bus_lock mutex. This can be seen in
i2c-core.c, in functions i2c_smbus_xfer() and i2c_transfer().

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
