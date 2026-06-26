% NOTE: This file is a plain-text extraction of the MATLAB code embedded
% inside project2AS.mlapp (App Designer apps store their source code in a
% zipped XML container that GitHub cannot render natively). This .m file
% is provided purely for readability/review on GitHub; it is NOT meant to
% be run directly, since classdef apps built with App Designer also rely
% on the GUI layout/component definitions stored in the .mlapp file.
% To actually run the app, open and run project2AS.mlapp in MATLAB.

classdef project2AS < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                      matlab.ui.Figure
        TabGroup                      matlab.ui.container.TabGroup
        AbsoluteStabilityRegionsvaryingmethodTab  matlab.ui.container.Tab
        PlotButton                    matlab.ui.control.Button
        SelectDrop2                   matlab.ui.control.DropDown
        SelezionametodoDropDownLabel  matlab.ui.control.Label
        UIAxes2                       matlab.ui.control.UIAxes
        AbsoluteStabilityRegionsvaryingpTab  matlab.ui.container.Tab
        ADMCheckBox                   matlab.ui.control.CheckBox
        ADBCheckBox                   matlab.ui.control.CheckBox
        ERKCheckBox                   matlab.ui.control.CheckBox
        SelectorderpDropDown          matlab.ui.control.DropDown
        SelectorderkLabel             matlab.ui.control.Label
        UIAxes                        matlab.ui.control.UIAxes
    end

    
    properties (Access = public)
        plotERK; % Description
        valuek % Description
    end
    
    properties (Access = public)
        plotADB % Description
        plotADM % Description
    end
    
 methods (Access = private)
        
 function absolute_regions_AB(app)
            
            theta = linspace(0,2*pi,500);
            u_imag = sqrt(-1); 
            P_k1 = []; P_k2 = []; P_k3 = []; P_k4 = []; P_k5 = [];
            for i=1:numel(theta)
                
                xi = exp(u_imag*theta(i));
                
                yi = xi-1; % k = 1
                P_k1 = [P_k1;[real(yi),imag(yi)]];
                
                yi = xi * (xi-1)./(1.5*xi-0.5); % k = 2;
                P_k2 = [P_k2;[real(yi),imag(yi)]]; 
                
                yi = 12*xi.^2*(xi-1)./(23*xi.^2-16*xi+5); % k = 3;
                P_k3 = [P_k3;[real(yi),imag(yi)]];
                
                yi = 24*xi.^3*(xi-1)./(55*xi.^3-59*xi.^2+37*xi-9); % k = 4;
                P_k4 = [P_k4;[real(yi),imag(yi)]];
                
                yi = 720*xi.^4*(xi-1)./(1901*xi.^4-2774*xi.^3+2616*xi.^2-1274*xi+251);
                % k = 5;
                P_k5 = [P_k5;[real(yi),imag(yi)]];
             
            end
            hold(app.UIAxes2,'on');
            grid(app.UIAxes2,'on');
            plot(app.UIAxes2,P_k1(:,1),P_k1(:,2),'b');
            plot(app.UIAxes2,P_k2(:,1),P_k2(:,2),'r');
            plot(app.UIAxes2,P_k3(:,1),P_k3(:,2),'g');
            plot(app.UIAxes2,P_k4(:,1),P_k4(:,2),'m');
            plot(app.UIAxes2,P_k5(:,1),P_k5(:,2),'k');
            legend(app.UIAxes2,'$p = 1$','$p = 2$','$p = 3$','$p = 4$',...
                '$p = 5$','fontsize',12,'location','east','interpreter','latex');
            title(app.UIAxes2,'Absolute stability regions',...
                'for Adam-Bashforth methods','interpreter','latex');
            xlabel(app.UIAxes2,'Re(z)');ylabel(app.UIAxes,'Imm(z)');
            hold(app.UIAxes2,'off');
            
            
        end
        
        function absolute_regions_AM(app)
            theta = linspace(0,2*pi,500);
            u_imag = sqrt(-1);
            P_k1 = []; P_k2 = []; P_k3 = []; P_k4 = []; P_k5 = [];
            
            for i=1:numel(theta)
     
                 xi = exp(u_imag*theta(i));
     
                 % k = 1
                 yi = 1- (1./xi);
                 P_k1 = [P_k1;[real(yi),imag(yi)]];
     
                 %k = 2
                 %yi = 2*(xi - 1)./(xi + 1);
                 %P_k2 = [P_k2;[real(yi),imag(yi)]];
                 x = [-6 -6 0 0];
                 y = [-4 4 4 -4];
     
                 %k  = 3;
                 yi = 12*xi.*(xi - 1)./(5*xi.^2+8*xi-1);
                 P_k3 = [P_k3;[real(yi),imag(yi)]];
     
                 %k = 4
                 yi = 24*xi.^2.*(xi - 1)./(9*xi.^3+19*xi.^2-5*xi+1);
                 P_k4 = [P_k4;[real(yi),imag(yi)]];
     
                 % k = 5
                 yi = 720*xi.^3.*(xi - 1)./(251*xi.^4+646*xi.^3-264*xi.^2+106*xi-19);
                 P_k5 = [P_k5;[real(yi),imag(yi)]];
            end
           
            hold(app.UIAxes2,'on')
            grid(app.UIAxes2,'on');
            %patch(app.UIAxes,x,y,[0.98 0.8 0.8]);
            plot(app.UIAxes2,P_k1(:,1),P_k1(:,2),'--b')
            %plot(P_k2(:,1),P_k2(:,2),'-k');
            patch(app.UIAxes2,x,y,[0.98 0.8 0.8],'edgecolor','none');
            plot(app.UIAxes2,P_k3(:,1),P_k3(:,2),'-g');
            plot(app.UIAxes2,P_k4(:,1),P_k4(:,2),'-m');
            plot(app.UIAxes2,P_k5(:,1),P_k5(:,2),'-k');
            legend(app.UIAxes2,'$p = 1$','$p = 2$','$p = 3$','$p = 4$',...
                '$p = 5$','fontsize',12,'location','northeast','interpreter','latex');
            title(app.UIAxes2,'Absolute stability regions',...
                'for Adam-Moulton methods','interpreter','latex');
            xlabel(app.UIAxes2,'Re(z)');ylabel(app.UIAxes,'Imm(z)');
            hold(app.UIAxes2,'off')     
        end
        
        
        function absolute_regions_ERK(app)
            
           %k = 1
           [X,Y] = meshgrid(-4:0.01:4,-4:0.01:4);
           Mu = X+i*Y;
           R = 1 + Mu ;
           Rhat = abs(R);

           hold(app.UIAxes2,'on');
           grid(app.UIAxes2,'on');
           contour(app.UIAxes2,X,Y,Rhat,[1,1],'b');
           
           %k = 2
           [X,Y] = meshgrid(-4:0.01:4,-4:0.01:4);
           Mu = X+i*Y;
           R = 1 + Mu + .5*Mu.^2 ;
           Rhat = abs(R);
           
           contour(app.UIAxes2,X,Y,Rhat,[1,1],'r');
           
           %k =3
           [X,Y] = meshgrid(-4:0.01:4,-4:0.01:4);
           Mu = X+i*Y;
           R =  1 + Mu + .5*Mu.^2 + (1/6)*Mu.^3;
           Rhat = abs(R);
           
           contour(app.UIAxes2,X,Y,Rhat,[1,1],'g');
           
           %k =4
           [X,Y] = meshgrid(-4:0.01:4,-4:0.01:4);
           Mu = X+i*Y;
           R =  1 + Mu + .5*Mu.^2 + (1/6)*Mu.^3 + (1/24)*Mu.^4;
           Rhat = abs(R);
           
           contour(app.UIAxes2,X,Y,Rhat,[1,1],'m');
  
           %k =5
           [X,Y] = meshgrid(-6:0.01:6,-6:0.01:6);
           Mu = X+i*Y;
           R4 = 1 + Mu + 1/2 *Mu.^2 + (1/6)*Mu.^3 + (1/24)*Mu.^4+(1/(120))*Mu.^5+ 1/1280 *Mu.^6;  
           Rhat4 = abs(R4);
           contour(app.UIAxes2,X,Y,Rhat4,[1,1],'k');

           legend(app.UIAxes2,'$p = 1$','$p = 2$','$p = 3$','$p = 4$','$p = 5$',...
               'fontsize',12,'location','northeast','interpreter','latex');
           title(app.UIAxes2,'Absolute stability regions',...
                'for Explicit Runge-Kutta methods','interpreter','latex');
            xlabel(app.UIAxes2,'Re(z)');ylabel(app.UIAxes,'Imm(z)');
           hold(app.UIAxes2,'off');  
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: Button
        
 function []= func(app,k)       
 theta=linspace(0,2*pi,500);
 u_imag=sqrt(-1);P=[];
    
 switch k

     case '1' %k = 1
         
     app.UIAxes.XLim=[-5, 5];
     app.UIAxes.YLim=[-5, 5];
     hold(app.UIAxes,'on');
     %ADB
     if app.plotADB
         theta=linspace(0,2*pi,500);
         u_imag=sqrt(-1);P=[];
         for i = 1:numel(theta)
             xi=exp(u_imag*theta(i)) -1;
             P=[P;[real(xi),imag(xi)]];
         end
      grid(app.UIAxes,'on');
      plot(app.UIAxes,P(:,1),P(:,2),'b','DisplayName','AB');   %k=1  BASHFORTH
      %legend(app.Uiaxes,)
      hold(app.UIAxes,'on');
     end
     
     %ADM
     if app.plotADM
         theta=linspace(0,2*pi,500);
         u_imag=sqrt(-1);P=[];
         for i = 1:numel(theta)
             xi=exp(u_imag*theta(i)) +1;
             P=[P;[real(xi),imag(xi)]];
         end
      grid(app.UIAxes,'on');
      plot(app.UIAxes,P(:,1),P(:,2),'--r','DisplayName','AM');  %k=1 moulton
      hold(app.UIAxes,'on');

     end
     
     %ERK
     if app.plotERK
         [X,Y] = meshgrid(-5:0.01:5,-5:0.01:5);   %ERK1
         Mu = X+u_imag*Y;
         R = 1 + Mu ;
         Rhat = abs(R);
      grid(app.UIAxes,'on');
      contour(app.UIAxes,X,Y,Rhat,[1,1],'g','DisplayName','ERK');
     end
      legend(app.UIAxes);

     hold(app.UIAxes,'off');

    case '2' %k =2
     %cla(app.UIAxes);
     app.UIAxes.XLim=[-5, 5];
     app.UIAxes.YLim=[-5, 5];
     hold(app.UIAxes,'on')
    %ABD    
    if app.plotADB
        for i = 1:numel(theta)
            xi=exp(u_imag*theta(i));
            yi=xi.*(xi-1)./(1.5*xi-0.5);
            P=[P;[real(yi),imag(yi)]];        %Adams-Bash k=2
        end
     grid(app.UIAxes,'on');
     plot(app.UIAxes,P(:,1),P(:,2),'b','DisplayName','AB');  
     hold(app.UIAxes,'on');
    end
    
    %ADM
    if app.plotADM
        grid(app.UIAxes,'on');
        xregion(app.UIAxes,-200,0,FaceColor='r',DisplayName='AB')   %MOULTON 2
        hold(app.UIAxes,'on');
    end
    
    %ERK
    if app.plotERK
        [X,Y] = meshgrid(-5:0.01:5,-5:0.01:5);
        Mu = X+u_imag*Y;
        R = 1 + Mu + .5*Mu.^2 ;
        Rhat = abs(R);
    grid(app.UIAxes,'on');
    contour(app.UIAxes,X,Y,Rhat,[1,1],'g','DisplayName','ERK');     %ERK2
    end
     legend(app.UIAxes);

    hold(app.UIAxes,'off');

    case '3' %k  = 3.
        
    %ADB   
    if app.plotADB
        %set to clear please
        for i = 1:numel(theta)      %Adams-b
            xi=exp(u_imag*theta(i));
            yi=12*(xi.^2 .*(xi-1))./(23*xi.^2-16*xi +5);
            P=[P;[real(yi),imag(yi)]];
        end
    %axis([-2.5 2 -1.5 1.5]);
    grid(app.UIAxes,'on');
    plot(app.UIAxes,P(:,1),P(:,2),'b','DisplayName','AB');   %k=3
    hold(app.UIAxes,'on');
    end
    
    %ADM
    if app.plotADM
        theta=linspace(0,2*pi,500);   %k=3
        u_imag=sqrt(-1);P=[];
        for i = 1:numel(theta)
            xi=exp(u_imag*theta(i));
            yi=12*xi.*(xi-1)./(5*xi.^2+8*xi-1);
            P=[P;[real(yi),imag(yi)]];        %Moult
        end
     grid(app.UIAxes,'on');
     plot(app.UIAxes,P(:,1),P(:,2),'r','DisplayName','AM');
     hold(app.UIAxes,'on');
     end
    
     %ERK
     if app.plotERK
         [X,Y] = meshgrid(-5:0.01:5,-5:0.01:5);
         Mu = X+u_imag*Y;
         R = 1 + Mu + .5*Mu.^2 + (1/6)*Mu.^3;
         Rhat = abs(R);
     grid(app.UIAxes,'on');
     contour(app.UIAxes,X,Y,Rhat,[1,1],'g','DisplayName','ERK');         %ERK3
     end
      legend(app.UIAxes);

     hold(app.UIAxes,'off');
     
     case '4' %k = 4.
       
     %ADB
     if app.plotADB  
         theta=linspace(0,2*pi,500);      %adams-b k=4
         u_imag=sqrt(-1);P=[];
         for i = 1:numel(theta)
             xi=exp(u_imag*theta(i));
             yi=24* xi.^3 .*(xi-1)./(55*xi.^3 - 59*xi.^2+ 37*xi-9);
             P=[P;[real(yi),imag(yi)]];
         end
     grid(app.UIAxes,'on');
     plot(app.UIAxes,P(:,1),P(:,2),'b','DisplayName','AB');
     hold(app.UIAxes,'on');
     end
     
     %ADM
     if app.plotADM
         P=[];
         for i = 1:numel(theta)
             xi=exp(u_imag*theta(i));
             yi=24*xi.^2*(xi-1)./(9*xi.^3+19*xi.^2-5*xi+1);
             P=[P;[real(yi),imag(yi)]];
         end
     grid(app.UIAxes,'on');
     plot(app.UIAxes,P(:,1),P(:,2),'r','DisplayName','AM');   %Moult k=4
     hold(app.UIAxes,'on');
     end
     
     %ERK4
     if app.plotERK
        [X,Y] = meshgrid(-5:0.01:5,-5:0.01:5);
        Mu = X+u_imag*Y;
        R = 1 + Mu + .5*Mu.^2 + (1/6)*Mu.^3 + (1/24)*Mu.^4;
        Rhat = abs(R);
     grid(app.UIAxes,'on');
     contour(app.UIAxes,X,Y,Rhat,[1,1],'g','DisplayName','ERK');
     end
      legend(app.UIAxes);

     hold(app.UIAxes,'off');

     case '5'
         
     if app.plotADB
         theta=linspace(0,2*pi,500);              %adams b k=5
         u_imag=sqrt(-1);P=[];
         for i = 1:numel(theta)
             xi=exp(u_imag*theta(i));
             yi=720* xi.^4 .*(xi-1)./(1901*xi.^4 - 2774*xi.^3+ 2616*xi.^2-1274*xi+251);
             P=[P;[real(yi),imag(yi)]];
         end
     grid(app.UIAxes,'on');
     plot(app.UIAxes,P(:,1),P(:,2),'b','DisplayName','AB');
     hold(app.UIAxes,'on');
     end
     
     if app.plotADM                      %adams m 5
         theta=linspace(0,2*pi,500); 
         u_imag=sqrt(-1);P=[];
         for i = 1:numel(theta)
             xi=exp(u_imag*theta(i));
             yi=720*xi.^3*(xi-1)./(251*xi.^4+646*xi.^3-264*xi.^2+106*xi-19);
             P=[P;[real(yi),imag(yi)]];
         end
     grid(app.UIAxes,'on');
     plot(app.UIAxes,P(:,1),P(:,2),'r','DisplayName','AM');
     hold(app.UIAxes,'on');
     end

     if app.plotERK
         [X,Y] = meshgrid(-6:0.01:6,-6:0.01:6);
         Mu = X+u_imag*Y;
         R4 = 1 + Mu + 1/2 *Mu.^2 + (1/6)*Mu.^3 + (1/24)*Mu.^4+(1/(120))*Mu.^5+ 1/1280 *Mu.^6;  
         Rhat4 = abs(R4);
     grid(app.UIAxes,'on');
     contour(app.UIAxes,X,Y,Rhat4,[1,1],'g','DisplayName','ERK');
     end
     legend(app.UIAxes);

     hold(app.UIAxes,'off');

     case '--'
           cla(app.UIAxes,'reset');
           grid(app.UIAxes,'on')
 end
 end
 end   

    % Callbacks that handle component events
    methods (Access = private)

        % Button down function: UIAxes
        function UIAxesButtonDown(app, event)
            
        end

        % Value changed function: SelectorderpDropDown
        function SelectorderpDropDownValueChanged(app, event)
            cla(app.UIAxes,'reset');
            app.valuek = app.SelectorderpDropDown.Value;
            x=linspace(0,1,200);
            grid(app.UIAxes,'on');
            switch app.SelectorderpDropDown.Value
                case '1'
                    app.UIAxes.XLim=[-5, 5];
                    app.UIAxes.YLim=[-5, 5];
                    grid(app.UIAxes,'on');
                     
                    func(app,'1')
                    
                case '2'
                     app.UIAxes.XLim=[-5, 5];
                     app.UIAxes.YLim=[-5, 5];
                     grid(app.UIAxes,'on');
                     func(app,'2');
                    
                case '3'
                    grid(app.UIAxes,'on');
                    func(app,'3');      
                case '4'
                    grid(app.UIAxes,'on');
                    func(app,'4');
                case '5'
                    grid(app.UIAxes,'on');
                    func(app,'5');
                case '--'
                    grid(app.UIAxes,'on');
                    func(app,'--');     
            end                     
        end

        % Value changed function: ERKCheckBox
        function ERKCheckBoxValueChanged(app, event)
            app.plotERK = app.ERKCheckBox.Value;
            %cla(app.UIAxes);
            k=app.valuek;
            if ~isempty(k)
                hold(app.UIAxes,'off');
                cla(app.UIAxes);
            func(app,k)
            else 
            func(app,'--');
            end
        end

        % Value changed function: ADBCheckBox
        function ADBCheckBoxValueChanged(app, event)
            app.plotADB= app.ADBCheckBox.Value;
            k=app.valuek;
            if ~isempty(k)
                hold(app.UIAxes,'off');
                cla(app.UIAxes);
            func(app,k)
            else 
            func(app,'--');
            end
        end

        % Value changed function: ADMCheckBox
        function ADMCheckBoxValueChanged(app, event)
            app.plotADM = app.ADMCheckBox.Value;
            k=app.valuek;
            if ~isempty(k)
                hold(app.UIAxes,'off');
                cla(app.UIAxes);
            func(app,k)
            else 
            func(app,'--');
            end
        end

        % Button pushed function: PlotButton
        function PlotButtonPushed(app, event)
             if strcmp(app.SelectDrop2.Value,'ERK')
                cla(app.UIAxes2);
                absolute_regions_ERK(app);      
             end
            
             if strcmp(app.SelectDrop2.Value,'AB')
                cla(app.UIAxes2);
                absolute_regions_AB(app) 
                
             end
             if strcmp(app.SelectDrop2.Value,'AM')
                cla(app.UIAxes2);
                absolute_regions_AM(app)  
             end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [1 1 640 480];

            % Create AbsoluteStabilityRegionsvaryingmethodTab
            app.AbsoluteStabilityRegionsvaryingmethodTab = uitab(app.TabGroup);
            app.AbsoluteStabilityRegionsvaryingmethodTab.Title = 'Absolute Stability Regions, varying method';

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.AbsoluteStabilityRegionsvaryingmethodTab);
            xlabel(app.UIAxes2, 'Re(z)')
            ylabel(app.UIAxes2, 'Im(z)')
            zlabel(app.UIAxes2, 'Z')
            app.UIAxes2.Position = [1 103 521 336];

            % Create SelezionametodoDropDownLabel
            app.SelezionametodoDropDownLabel = uilabel(app.AbsoluteStabilityRegionsvaryingmethodTab);
            app.SelezionametodoDropDownLabel.HorizontalAlignment = 'right';
            app.SelezionametodoDropDownLabel.Position = [19 56 104 22];
            app.SelezionametodoDropDownLabel.Text = 'Seleziona metodo:';

            % Create SelectDrop2
            app.SelectDrop2 = uidropdown(app.AbsoluteStabilityRegionsvaryingmethodTab);
            app.SelectDrop2.Items = {'ERK', 'AM', 'AB'};
            app.SelectDrop2.Position = [138 56 77 22];
            app.SelectDrop2.Value = 'ERK';

            % Create PlotButton
            app.PlotButton = uibutton(app.AbsoluteStabilityRegionsvaryingmethodTab, 'push');
            app.PlotButton.ButtonPushedFcn = createCallbackFcn(app, @PlotButtonPushed, true);
            app.PlotButton.Position = [530 296 100 23];
            app.PlotButton.Text = 'Plot';

            % Create AbsoluteStabilityRegionsvaryingpTab
            app.AbsoluteStabilityRegionsvaryingpTab = uitab(app.TabGroup);
            app.AbsoluteStabilityRegionsvaryingpTab.Title = 'Absolute Stability Regions, varying p';

            % Create UIAxes
            app.UIAxes = uiaxes(app.AbsoluteStabilityRegionsvaryingpTab);
            xlabel(app.UIAxes, 'Re(z)')
            ylabel(app.UIAxes, 'Im(z)')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.NextPlot = 'add';
            app.UIAxes.ButtonDownFcn = createCallbackFcn(app, @UIAxesButtonDown, true);
            app.UIAxes.Position = [237 77 393 336];

            % Create SelectorderkLabel
            app.SelectorderkLabel = uilabel(app.AbsoluteStabilityRegionsvaryingpTab);
            app.SelectorderkLabel.HorizontalAlignment = 'right';
            app.SelectorderkLabel.Position = [8 391 86 22];
            app.SelectorderkLabel.Text = ' Select order p:';

            % Create SelectorderpDropDown
            app.SelectorderpDropDown = uidropdown(app.AbsoluteStabilityRegionsvaryingpTab);
            app.SelectorderpDropDown.Items = {'--', '1', '2', '3', '4', '5'};
            app.SelectorderpDropDown.ValueChangedFcn = createCallbackFcn(app, @SelectorderpDropDownValueChanged, true);
            app.SelectorderpDropDown.Position = [142 391 73 22];
            app.SelectorderpDropDown.Value = '--';

            % Create ERKCheckBox
            app.ERKCheckBox = uicheckbox(app.AbsoluteStabilityRegionsvaryingpTab);
            app.ERKCheckBox.ValueChangedFcn = createCallbackFcn(app, @ERKCheckBoxValueChanged, true);
            app.ERKCheckBox.Text = 'ERK';
            app.ERKCheckBox.Position = [47 260 47 22];

            % Create ADBCheckBox
            app.ADBCheckBox = uicheckbox(app.AbsoluteStabilityRegionsvaryingpTab);
            app.ADBCheckBox.ValueChangedFcn = createCallbackFcn(app, @ADBCheckBoxValueChanged, true);
            app.ADBCheckBox.Text = 'ADB';
            app.ADBCheckBox.Position = [47 217 47 22];

            % Create ADMCheckBox
            app.ADMCheckBox = uicheckbox(app.AbsoluteStabilityRegionsvaryingpTab);
            app.ADMCheckBox.ValueChangedFcn = createCallbackFcn(app, @ADMCheckBoxValueChanged, true);
            app.ADMCheckBox.Text = 'ADM';
            app.ADMCheckBox.Position = [47 175 49 22];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = project2AS

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end