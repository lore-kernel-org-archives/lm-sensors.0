From: rafael.espindola@gmail.com (Rafael =?iso-8859-1?q?=C1vila_de_Esp=EDndola?=)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: lsb in emc6d102 and adm1027
Message-Id: <200503210842.52407.rafael.espindola@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200503201236.33120.rafael.espindola@gmail.com>
In-Reply-To: <200503201236.33120.rafael.espindola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Em Mon 21 Mar 2005 04:40, Philip Pokorny escreveu:
>
> This doesn't look right.  The lm85_read_value() function generally only
> returns an 8-bit value.  In some cases it returns 16 bits but those are
> exceptions, and you haven't added the EMC6D102 registers to that
> exception list.
>
> So how can you shift ext4, ext3, ext1, etc right 8 bits and have a value
> with any meaning?
>
> Perhaps you meant to shift by only 4 bits to get the high nibble?
> :v)

Yes, you are wright. What a embarrassing error....

A corrected patch is attached. Thanks.

Rafael

Signed-off-by: Rafael ?vila de Esp?ndola <rafael.espindola@gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: emc6d102-kernel.patch
Type: text/x-diff
Size: 7526 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050321/a408e4f3/emc6d102-kernel.bin
