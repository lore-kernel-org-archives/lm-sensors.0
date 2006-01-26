From: jim.cromie@gmail.com (Jim Cromie)
Date: Thu, 26 Jan 2006 18:56:14 +0000
Subject: [lm-sensors] [patch 0/6] hwmon/pc87360: various locking touches
Message-Id: <43D91B4E.9070007@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <43D7FB0B.9090108@gmail.com>
In-Reply-To: <43D7FB0B.9090108@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jim Cromie wrote:

> hi Jean, everyone,
>
> This patchset applies on 16rc1-mm3.  Individual descriptions
> follow my series-file.  The 1st 3 patches are solid, and I think
> ready for review and submission, 4-6 need discussion.
> Also, 6 obsoletes 1.
>
Scratch this -
Im gonna send patches 2,3 separately, since theyre not locking related,
they work, and should be non-controversial.

Then Ill send 4.5 as an RFC.


> 1. diff.pc-update-lock-only-when-refetching
> 2. hwmon-pc87360-use-sensor-attr-2.patch
> 3. hwmon-pc87360-sysfs-combo-callbacks.patch
> 4. diff.siolocks-beta2
> 5. diff.uselocks.hilock


hope this clarifies.

