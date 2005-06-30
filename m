From: salahx@yahoo.com (Salah Coronya)
Date: Thu, 30 Jun 2005 23:40:01 +0000
Subject: [lm-sensors] PnP and W83627HF/W83781D IO port conflict at
Message-Id: <42C46675.4050105@yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42C3900F.9090108@coronya.com>
In-Reply-To: <42C3900F.9090108@coronya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Salah,
> 
> 
>>My motherboard, an ASUS P4B-LX has a W83627HF chip on it (as detected
>>by sensors-detect) that has the sensor reading on it,and more
>>importantly, allow control of the fan via PWM.
>>
>>However, the W83781D module does not work - it loads, but nothing
>>happens. When i2c debugging message are enabled, it print the error
>>message "Request of region 0x290-0x297 for w83781d failed", although
>>it still loads. In
>>/proc/ioports it shows "pnp 00:0d" at port 0x0295-0x0296 both with and
>>without the module loaded.
>>
>>Forcing it gives the same error and results. Passing
>>pnp_reserve_io=0x0290,8 in the command line has no effect, and no
>>error message or acknowlegement about the parameter either, even with
>>PNP Debug output.
>>
>>If PNP is disabled in the kernel, I can access the sensor, get the
>>sensors readings, and control the fan.
> 
> 
> The culprit isn't PNP itself but PNPACPI. The problem is known, see:
>   http://bugzilla.kernel.org/show_bug.cgi?id@14
> 
> Feel free to add a "me too" there so that the person responsible for it
> knows that it does annoy people. Not sure there is anything we can do
> though, as this is a BIOS bug. Ideally the motherboard manufacturer
> should release an updated BIOS.
> 

Ok, will do. For now, I've disabled PNPACPI and switched to PNPBIOS to
workaround the problem in the meantime. Thanks!
