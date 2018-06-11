【dataset】Chui-Rangarajan Synthesized Data Sets





https://avaminzhang.wordpress.com/2012/12/05/%E3%80%90dataset%E3%80%91chui-rangarajan-synthesized-data-sets/






Synthetic data is easy to get and can be designed to test a specified aspect of the algorithms.

There are three sets of data designed to measure the robustness of an algorithm under deformation, noise and outliers.

In each test, the model point set is subjected to one of the above distortions to create a “target” point set. And then we run our algorithm to find the correspondence between these two sets of points and use the estimated correspondence to warp the model.

The accuracy of the matching is quantified as the average Euclidean distance between a point in the warped model and the correspondent point in the target.100 samples are generated for each degradation level.  Several examples from the synthetic data sets are shown as follows: 



save_{fish,chinese,hand}_{def,noise,outlier}_m_n.mat
The value of m refers to the test number, n refers to the test example number. The range of m is 1-5 for deformation and outlier, 1-6 for noise. The range of n is 1-100.

Example: save_fish_outlier_3_2.mat
This corresponds to the “fish” shape, outlier test, test no. 3 (out of 5), corresponding to 100% outlier to data ratio, example no. 2.

Each file contains the model data (x1), the target data (y2a), and in the case of the noise test, the target data before adding noise (y2).

A matching approach should be:

invariant under scaling and translation
Invariance to translation is intrinsic to the shape context, since all measurements are taken w.r.t points on the object
scale invariance: we normalize all radial distances by the mean distance between the n*n point pairs in the shape.
robust under small geometrical distortions, occlusion and presence of outliers
Shape context is insensitive to small perturbations of parts of the shape.
Robustness to small nonlinear transformations, occlusions and presence of outliers is evaluated experimentally
Complete rotation invariance: to use a relative frame based on treating the tangent vector at each point as the positive x-aixs. ===so the reference frame turns with the tangent angle,
In certain applications, one may want complete invariance under rotation, or even the full group of affine transformations.

But in many applications, complete invariance impedes recognition performance, e.g., distinguishing 6 from 9 rotation invariance would be completely inappropriate. Many points will not have well-defined or reliable tangents.

Many local appearance features lose their discriminative power if they are not measured in the same coordinate system.

Thin Plate Spline model is commonly used for representing flexible coordinate transformations.

TPS is the 2D generalization of the cubic spline

Handwriting is a kind of non-rigid shape.
