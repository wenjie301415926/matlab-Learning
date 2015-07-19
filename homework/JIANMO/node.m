classdef node <handle
    properties
       data
    end
    properties(SetAccess = public)
       next
    end
    
    methods
       function node = node(data)
           if nargin > 0
                node.data=data;
           end
       end
      end

end