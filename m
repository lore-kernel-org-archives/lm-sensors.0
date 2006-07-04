From: multinymous@gmail.com (Shem Multinymous)
Date: Tue, 04 Jul 2006 10:33:07 +0000
Subject: [lm-sensors] [Hdaps-devel] Generic interface for accelerometers
Message-Id: <41840b750607040333w6d7afb76t100570ffabf67761@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <41840b750607040326y7bfe92dy21c6845ab034ce30@mail.gmail.com>
In-Reply-To: <41840b750607040326y7bfe92dy21c6845ab034ce30@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 7/3/06, Henrique de Moraes Holschuh <hmh at debian.org> wrote:
> If any kernel-space functionality needed by HDAPS and AMS is also shared, we
> would have benefits there too.
[snip]
> queue-freeze and HD head parking

Is there any difference between the freeze+park functionality needed
by the different laptops? The hdaps_protect patch has a well thought
out generic interface, and can probably serve all projects. What's the
prospect of seeing it in mainline? (Of course, the recently reported
hangs need to be addressed first.)

  Shem

