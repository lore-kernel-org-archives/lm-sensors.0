From: dimitrios@michelinakis.gr (Dimitrios 'sehh' Michelinakis)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: ticket# 1649 - i2c-viapro fails to load
Message-Id: <20040416090641.52b328fd@ekolaptis.>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040415151411.2efbffc1@ekolaptis.>
In-Reply-To: <20040415151411.2efbffc1@ekolaptis.>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 16 Apr 2004 09:49:34 +0200 Jean Delvare <khali@linux-fr.org> wrote:

> First, you have to pay attention that there are two parts in the
> lm_sensors project:
> 1* Kernel modules
> 2* User-space tools.
> All distributions that include lm_sensors have *two* distinct packages
> for these. In some (most) cases the kernel modules are part of the
> kernel package, while the user-space tools are in a lm-sensors package.
> So I suspect that you have been upgrading only the lm-sensors package,
> and *not* the kernel package, while you should have done that as well.

i think thats whats happening. i've been updating the user space tools only.
 

> So you should try upgrading kernels and see how it goes.

i'm already running the latest fedora kernel. so there is nothing i can do
about this, unless fedora releases a new kernel soon with updated modules.

 
> If you can't get it to work, you may want to give a try to Axel Thimm's
> packages:
> Userspace tools at http://atrpms.net/name/lm_sensors/
> Kernels at http://atrpms.net/name/kernel/

thank you, your help is much appriciated.


-- 
Dimitrios Michelinakis
www.ionos.gr Web Services
