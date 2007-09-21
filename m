From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 21 Sep 2007 07:24:00 +0000
Subject: Re: [lm-sensors] libsensors API changes
Message-Id: <46F37190.7060601@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070919234452.4896c76d@hyperion.delvare>
In-Reply-To: <20070919234452.4896c76d@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi all,
> 
> In the past few days, I have been thinking about the libsensors4 API,
> in particular the way the chip features are accessed. Right now we have
> a single function, sensors_get_all_features(), returning all features
> in sequence, mixing main features and subfeatures. Actually, main
> features and subfeatures are only differentiated by the mapping field
> value, but otherwise they are represented by the same structure.
> 
> Looking at the code of several user-space applications using
> libsensors, this interface is not very convenient. Except for "sensors
> -u", which makes some sense as I think it is the reason why this
> interface exists in the first place. Here is a list of things I found
> the applications would take benefit of if libsensors would propose a
> suitable interface:
> 
> * Separate lists for main features and subfeatures of each main feature.
> 

+1

> * Subfeature existence information (does feature F of chip C have
> subfeature X?)
> 

+1

> * Direct subfeature value lookup (what's the value of subfeature X of
> feature F of chip C?)
> 

+1

> So I am in the process of extending the libsensors4 API to implement
> these interfaces. The first point can be either done easily (simply
> splitting sensors_get_all_features() to two separate functions) or
> taken further: I think it would make sense to have a separate structure
> for main features or "channels" (e.g. in0, temp1...) and for
> subfeatures (e.g. in0_input, temp1_min...) This would make things much
> more structured. For example, labels essentially apply to main
> features, not subfeatures. Same goes for compute statements. OTOH, set
> statements apply to subfeatures, not main features.
> 
> Going that route would speed up the library code at some places. It
> would also let us clear the fooN / fooN_input confusion which forces us
> to have some ugly hard-coded exceptions in the library. The drawback is
> that we may lose some flexibility by going that route, so I'm not sure
> how far we want to go.
> 
> The last two points would avoid some duplication in applications, and
> would make their code look much nicer. There is a concern with
> algorithmic complexity though: direct value lookups are likely to be in
> O(N) while for example "sensors" manages to do it in O(1) at the
> moment. However, the number of subfeatures being relatively small for
> each main feature, it might not be an issue at all.
> 
> I am working on some patches implementing these API changes, I hope to
> be able to post them for comments and review at the end of the week.
> Until then, I would also welcome comments on the general ideas I just
> exposed.
> 


The basic ideas I'm vary much in favor off, as for the under the hood 
implementation, I haven't given much thought to that, I trust you will come up 
with something good.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
