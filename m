From: david.c.hubbard@gmail.com (David Hubbard)
Date: Sat, 09 Dec 2006 21:38:43 +0000
Subject: [lm-sensors] [PATCH 6/8] w83627ehf: Fix the detection of fan5
Message-Id: <4dfa50520612091338m6b84800am888b55f4f51998d4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11612021961186-git-send-email-greg@kroah.com>
In-Reply-To: <11612021961186-git-send-email-greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Christian,

You have a w83627dhg, if I remember correctly. The current driver you
are probably using is the testing driver from the lm-sensors mailing
list in September. Although it functions correctly for the w83627dhg,
it does not correctly detect some of the w83627ehf chip revisions.
I've taken way too long to get the driver fixed so it can be added to
the kernel. Mostly that's because my work has become very intense for
the last few months -- I haven't been sleeping much. However,
w83627dhg support should be in a testing release of the kernel soon.
(Possibly 2.6.20)

David

On 12/9/06, Christian Mahr <christian.mahr.ulm at arcor.de> wrote:
> Hi David,
>
> I always could read fans5 on my P5B wifi deluxe board.
>
> I am still on 2.6.18.2 kernel with your version of w83627ehf driver (and
> Rudolfs coretemp patch).
> anything you want me to try out?
>
> Christian

