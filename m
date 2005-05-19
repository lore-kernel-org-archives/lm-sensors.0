From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <Pine.LNX.4.58.0503091845050.25688@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> ali1535_smbus 0000:00:03.1: ALI1535_smb region uninitialized - upgrade
> BIOS?
> ali1535_smbus 0000:00:03.1: ALI1535 not detected, module not inserted.

Did you try to load wrong module? (or maybe sensor-detect tried?) There
was no reboot between this and next lines?

> ali1563: SMBus control = 5003
> i2c_adapter i2c-0: registered as adapter #0
> ali1563_probe: Returning 0
>

Pease let me know how the first 1535 got there.
Please can you provide

lspci -xxx
and cat /proc/ioports (before and after loading the driver) ?

Thanks

regards

Rudolf


PS:
I will be in Paris (from tomorrow evening) until Sunday++; But lets hope I
will find some internet connection there.
