From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 06 Mar 2007 15:19:35 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <20070306161935.025a3ec1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <7PvLN-1cj-3@gated-at.bofh.it>
	<7TEGV-6Jy-39@gated-at.bofh.it>
	<7TUBX-6TN-5@gated-at.bofh.it>
	<7UeqX-4QO-17@gated-at.bofh.it>
	<7UeqZ-4QO-27@gated-at.bofh.it>
	<7UgM5-np-1@gated-at.bofh.it>
	<7UgM8-np-11@gated-at.bofh.it>
	<7UnaS-2xP-9@gated-at.bofh.it>
	<7UnkC-2JB-9@gated-at.bofh.it>
	<7Uzcd-49u-3@gated-at.bofh.it>
	<7UEEN-4xi-3@gated-at.bofh.it>
	<E1HODgC-0000h8-Vc@be1.lrz>
In-Reply-To: <E1HODgC-0000h8-Vc@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bodo Eggert <7eggert@gmx.de>
Cc: David Hubbard <david.c.hubbard@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Pavel Machek <pavel@ucw.cz>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, Chuck Ebbert <cebbert@redhat.com>, Rudolf@atrpms.net

Hi Bodo,

On Mon, 05 Mar 2007 14:56:44 +0100, Bodo Eggert wrote:
> 1) Make a general resource allocation lock, if there is none.

Such a lock certainly exists, but I doubt it is public at the moment.

> 2) make ACPI take this lock whenever it touches ports not allocated by itself
>    and release it on function return.

This is costly.

> 3) Make ACPI callback the allocating device if it touches allocated ranges,
>    and on function return.

By callback, do you mean port forwarding as Rudolf Marek did, or more
simple "stop touching the device" and "you can touch the device again"
sort of signals? If the latter, this is no different from a mutex.

> 1 + 2 will replace allocating single ports and freeing them again (so ACPI won't
> prevent e.g. the display driver from loading just because it turned on the
> backlight) while preventing races with newly allocated ranges, and 3 allows
> coexistence with other drivers.

What benefit do you see compared to a lock taken by both AML and the
hardware monitoring drivers?

Care to submit a sample implementation?

Thanks,
-- 
Jean Delvare

