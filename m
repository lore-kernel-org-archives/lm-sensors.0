From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 29 May 2006 09:10:43 +0000
Subject: [lm-sensors] PATCH: abituguru driver
Message-Id: <20060529111043.0841a44d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4470B10F.7070502@hhs.nl>
In-Reply-To: <4470B10F.7070502@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> This is what I had in mind too, done. The attached patch fixes this as
> requested and also fixes the requested should fixes, changes:
>  - exactly calculate the sysfs_names array length using macro
>  - use snprintf when generating names to double check that the
>    sysfs_names array does not overflow.
>  - use ARRAY_SIZE and / or defines to determine number of loops in for
>    loops instead of using hardcoded values.
>  - In abituguru_probe(), refactor the error path leaving a single call
>    to kfree

Looks good, thanks! I'll push the abituguru driver upstream in the next
batch of patches (not scheduled yet.)

-- 
Jean Delvare

