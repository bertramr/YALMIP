function opts = cplexmergeoptions(newopts)
opts = cplexoptimset('cplex');
opts = merge(opts, newopts);

    function out = merge(out, in)
        in_fields = fieldnames(in);
        out_fields = fieldnames(out);
        for i = 1:length(in_fields)
            if ismember(in_fields{i},out_fields)
                if isstruct(out.(in_fields{i}))
                    out.(in_fields{i}) = merge(out.(in_fields{i}), in.(in_fields{i}));
                else
                    out.(in_fields{i}) = in.(in_fields{i});
                end
            else
                warning('cplexmergeoptions:NotSupportedOption','"%s" is not a supported option - discarded',in_fields{i});
            end
        end
    end

end
function test_cplexmergeoptions
% Test
clear;
newopts.threads = 4;
opts = cplexmergeoptions(newopts);
assert(opts.threads == 4);

clear;
newopts.Display = 'on';
opts = cplexmergeoptions(newopts);
assert(not(isfield(opts,'Display')),'Fields are added');

clear;
newopts.simplex.display = 2;
opts = cplexmergeoptions(newopts);
assert(opts.simplex.display == 2);
assert(isfield(opts.simplex,'crash'),'Fields are removed');
end