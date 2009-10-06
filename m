From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 06 Oct 2009 14:10:14 +0000
Subject: Re: [lm-sensors] [PATCH 0/2] asus_atk0110: refactor and support for
Message-Id: <20091006161014.5eedd16a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091006115023.697932717@gmail.com>
In-Reply-To: <20091006115023.697932717@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Luca,

On Tue, 06 Oct 2009 13:50:23 +0200, Luca Tettamanti wrote:
> Hello Jean,
> I'm sending two patches for asus_atk0110:
> - the first one is mostly refactoring to allow easier extension of the driver;
>   it also extends GITM to handle buffers larger than 8 bytes.
> - the second one add support for enabling/disabling EC

I've applied both patches. Should I delay them until kernel 2.6.33, or
is it desirable (and safe) to have them in kernel 2.6.32?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
