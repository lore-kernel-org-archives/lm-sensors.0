From: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: [patch 2/9]Four new i2c drivers and __init/__exit cleanup toi2c
Message-Id: <3D8777AC.7000000@mandrakesoft.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D85E7E8.5EEC1499@attbi.com>
In-Reply-To: <3D85E7E8.5EEC1499@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Albert Cranford wrote:
> Hi Jeff,
> I think I noted that compatibility stuff will not be
> checked in, but noted here for linux-2.5.xx.  This is
> something that I have to manually ignore when diffing 
> CVS and kernel.  And yes EXPORT_NO_SYMBOLS is explicitly
> defined now in 2.5.xx, but no harm in redundency, so I'll
> leave it in the code.
> 
> I repaired the call to request_region and also removed an
> unneeded call to request_region from the else path.
> 
> Now I need someone to test it in the different versions.
> 
> New change set.
> Albert
> --- i2c-pport.c 2002-09-12 02:55:47.000000000 -0400
> +++ /usr/src/linux/drivers/i2c/i2c-pport.c      2002-09-17 08:39:20.000000000 -0400


Yes, this patch looks fine to me...
