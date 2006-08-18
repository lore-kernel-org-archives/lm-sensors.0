From: bezaur@gmail.com (Charles Spirakis)
Date: Fri, 18 Aug 2006 17:35:36 +0000
Subject: [lm-sensors] [PATCH] w83791d - swap bit 1 and bit 13 in
Message-Id: <5bfe43f80608181035j3f40cec4gda5572fe5b985bae@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80608030057w2a35591ag2f6bd7b771b0c568@mail.gmail.com>
In-Reply-To: <5bfe43f80608030057w2a35591ag2f6bd7b771b0c568@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Based on discussions with Jean, this patch is rescinded. A
documentation only patch has been submitted to explain the fact that
the beep enable and alarm bits are different and that it is up to
user-mode to handle those differences.

On 8/3/06, Charles Spirakis <bezaur at gmail.com> wrote:
> From: Charles Spirakis <bezaur at gmail.com>
>
> The alarm and beep enable bits are close to being the same but bit 1 and
> bit 13 are swapped. This patch swaps those bits on the beep enable side
> so that user-mode doesn't need to know. Also, the w83791d official
> documentation for the alarm bits doesn't seem to match reality so
> update the driver documentation to reflect reality.  Patch was originally
> submitted by Sven Anders.
>
> Signed-off by: Sven Anders <anders at anduras.de>
> Signed-off by: Charles Spirakis <bezaur at gmail.com>
>
> ---
>
>  Documentation/hwmon/w83791d |   43 ++++++++++++++++++++++++++-----------------
>  drivers/hwmon/w83791d.c     |   33 ++++++++++++++++++++++++++++++---
>  2 files changed, 56 insertions(+), 20 deletions(-)
>
>
>

