From: mathog@mendel.bio.caltech.edu (David Mathog)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: ticket 1775
Message-Id: <E1C9SUZ-0007UN-00@mendel.bio.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1C9PtS-000754-00@mendel.bio.caltech.edu>
In-Reply-To: <E1C9PtS-000754-00@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hmm, this is odd (full sensors.conf attached, key parts
below):

    label in0 "VCore 1"
    label in1 "VCore 2"
    set in0_min vid*0.90
    set in0_max vid*1.05
    set in1_min vid*0.90
    set in1_max vid*1.05

VCore 1:   +1.73 V  (min =  +1.66 V, max =  +1.94 V)       ALARM  
VCore 2:   +1.73 V  (min =  +1.66 V, max =  +1.94 V)              

Why an alarm?

 1.66 <= 1.73 <= 1.94

Thanks,

David Mathog
mathog@caltech.edu
Manager, Sequence Analysis Facility, Biology Division, Caltech
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/octet-stream
Size: 2627 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040920/a8edf84a/attachment.obj
