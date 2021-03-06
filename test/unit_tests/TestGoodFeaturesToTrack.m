classdef TestGoodFeaturesToTrack
    %TestGoodFeaturesToTrack
    properties (Constant)
        img = 255 * uint8([...
            0 0 0 0 0 0 0 0 0 0 0 0 0;...
            0 0 0 0 0 0 0 0 0 0 0 0 0;...
            0 0 0 0 0 0 0 0 0 0 0 0 0;...
            0 0 0 0 0 0 0 0 0 0 0 0 0;...
            0 0 0 0 1 1 1 1 0 0 0 0 0;...
            0 0 0 0 1 1 1 1 0 0 0 0 0;...
            0 0 0 0 1 1 1 1 0 0 0 0 0;...
            0 0 0 0 1 1 1 1 0 0 0 0 0;...
            0 0 0 0 0 0 0 0 0 0 0 0 0;...
            0 0 0 0 0 0 0 0 0 0 0 0 0;...
            0 0 0 0 0 0 0 0 0 0 0 0 0;...
            0 0 0 0 0 0 0 0 0 0 0 0 0;...
            0 0 0 0 0 0 0 0 0 0 0 0 0;...
        ]);
    end

    methods (Static)
        function test_1
            corners = cv.goodFeaturesToTrack(TestGoodFeaturesToTrack.img);
            validateattributes(corners, {'cell'}, {'vector'});
            cellfun(@(v) validateattributes(v, {'numeric'}, ...
                {'vector', 'numel',2}), corners);
        end

        function test_options
            corners = cv.goodFeaturesToTrack(TestGoodFeaturesToTrack.img, ...
                'MaxCorners',1000, 'QualityLevel',0.01, 'MinDistance',2.0, ...
                'BlockSize',3, 'UseHarrisDetector',false, 'K',0.04);
        end

        function test_mask
            mask = false(size(TestGoodFeaturesToTrack.img));
            mask(2:end-1,2:end-1) = true;
            corners = cv.goodFeaturesToTrack(TestGoodFeaturesToTrack.img, ...
                'Mask',mask);
        end

        function test_error_1
            try
                cv.goodFeaturesToTrack();
                throw('UnitTest:Fail');
            catch e
                assert(strcmp(e.identifier,'mexopencv:error'));
            end
        end
    end

end
