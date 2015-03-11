From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 11 Mar 2015 19:55:24 +0000
Subject: Re: [lm-sensors] 3.x i2c-mux-pca954x vs 2.6.x i2c-pca954x
Message-Id: <20150311205524.289478d0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAPQE1b92dT-MqOBBpNBtCuDYKJE1M5iQSyWO67ZOb7MsXMJD3A@mail.gmail.com>
In-Reply-To: <CAPQE1b92dT-MqOBBpNBtCuDYKJE1M5iQSyWO67ZOb7MsXMJD3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 11 Mar 2015 11:36:28 -0700, Craig MacFarlane wrote:
> Folks, I'm trying to migrate to the 3.x kernel and I have
> some software that wants to instantiate the virtual
> bus driver for pca954x devices.
> 
> I used to do this as so...
> 
>   modprobe i2c-pca954x force_pca9548=0,0x77
> 
> That no longer works as the force parameter has
> gone away.  Fair enough.  But I can't seem to find
> the magic incantation to make this work in the
> new_device mechanism.
> (...)
> Anyone have any idea how to make this work?

echo pca9548 0x77 > /sys/bus/i2c/devices/i2c-0/new_device

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
