From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 26 Dec 2006 09:08:27 +0000
Subject: [lm-sensors] w83793 driver ready
Message-Id: <20061226100827.3ec967dd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061208153817.de1c2b4c.khali@linux-fr.org>
In-Reply-To: <20061208153817.de1c2b4c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dz,

On Tue, 26 Dec 2006 10:31:08 +0800, DZShen at winbond.com wrote:
>   I am very interested in how do you know which motherboards are
> equipped with Winbond 793. Even for the ASUS motherboard with 627DHG I
> purchased, I had to consult our FAE.
> 
>   Where did you get this information?

I searched for "w83793g" in google. And I also searched the lm-sensors
mailing list for reports of users interested in the driver. Sometimes I
had to download the motherboard manual for confirmation. The list I
came up with is:

Tyan Tempest i5000VF (S5370)
Tyan Tempest i5000PT (S5383)
Supermicro PDSMU
Supermicro X7DBR-3
Supermicro X7DBR-E
Supermicro H8DAE-2

I agree with you that this kind of information is rather difficult to
find. Unfortunately, most vendors do not mention the name of the
hardware monitoring chip in the motherboard specification pages.

-- 
Jean Delvare

