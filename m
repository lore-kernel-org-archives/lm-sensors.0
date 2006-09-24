From: thwalker3@gmail.com (Thomas Walker)
Date: Sun, 24 Sep 2006 03:32:39 +0000
Subject: [lm-sensors] #2109: Supermicro X7DAE support
Message-Id: <3d8b047a0609232032j26603a5gce7e36b39e4e6175@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks.  There was an ugly kernel build problem in 2.6.17-1.2174 (fc5) that
was causing me problems testing this patch but 2187 resolved the problem
(nothing to do with this patch in particular, the actual kernel build
process was broken).

Seems to be giving accurate results (i.e. I unplug a fan for a bit and the
cooresponding temp drifts upwards).

Submitted to redhat bugzilla as a feature request (#207826) to get them
looking at it.  If there are updates to the patch (including upstream
submission) a note should probably go there as well.

Thanks again for the great support...

On 9/20/06, lm-sensors <lm-sensors-notify at lm-sensors.org> wrote:
>
> #2109: Supermicro X7DAE support
>
> ----------------------------------+-----------------------------------------
>   Reporter:  thwalker3 at gmail.com  |       Owner:  ruik
>       Type:  enhancement          |      Status:  closed
>   Priority:  minor                |   Milestone:
> Component:  hardware             |     Version:  CVS/SVN
> Resolution:  fixed                |    Keywords:
>
> ----------------------------------+-----------------------------------------
> Changes (by ruik):
>
>   * status:  assigned => closed
>   * resolution:  => fixed
>
> Comment:
>
> I'm closing this ticket. If you have encounter some problems with new
> driver, please open new one.
>
> Rudolf
>
> --
> Ticket URL: <http://www.lm-sensors.org/ticket/2109#comment:6>
> lm-sensors <http://lm-sensors.org/>
> Linux hardware monitoring
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060923/484d92ac/attachment.html 
