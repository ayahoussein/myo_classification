function [timeline_out, sig_out] = interpolate_missing_samples(timeline_in, sig_in, T)
%Input: (original timeline, original signal, sampling period)
%Output: (interpolated timeline, interpolated signal)

[~, ind] = unique(timeline_in);
t1 = timeline_in(ind);

timeline_int = interp1(ind, t1, 1:length(timeline_in));
timeline_int(end) = timeline_int(end-1)+mean(diff(timeline_int(1:end-1)));

timeline_out = 0:T:timeline_int(end);
sig_out = interp1(timeline_int, sig_in, timeline_out);

end
